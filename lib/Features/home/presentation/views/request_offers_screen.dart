import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/presentation/cubit/requests_cubit.dart';
import 'package:motoverse/Features/home/data/models/offer_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';
import 'package:motoverse/Features/home/presentation/cubit/notification_cubit.dart';
import 'package:motoverse/Features/home/presentation/widgets/request_offer_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RequestOffersScreen extends StatelessWidget {
  const RequestOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final List<RequestModel>? requests = arguments is List<RequestModel>
        ? arguments
        : null;

    if (requests == null || requests.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('حدث خطأ في تحميل البيانات')),
      );
    }

    debugPrint(requests.first.id.toString());
    return BlocProvider(
      create: (context) =>
          NotificationCubit(getIt<HomeRepo>())
            ..getOffers(requestId: requests.first.id),
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is UpdateOfferStatusLoading) {
            // Optional: show a global loading indicator
          } else if (state is UpdateOfferStatusSuccess) {
            customSnackBar(
              context: context,
              msg: 'تم تحديث حالة العرض بنجاح',
              isDone: true,
            );
            context.read<NotificationCubit>().getOffers(
              requestId: requests.first.id,
            );
          } else if (state is UpdateOfferStatusFailure) {
            customSnackBar(
              context: context,
              msg: state.errMessage,
              isDone: false,
            );
          } else if (state is DeleteRequestLoading) {
            // Optional: show a global loading indicator
          } else if (state is DeleteRequestSuccess) {
            context.read<RequestsCubit>().removeRequest(requests.first.id);
            customSnackBar(
              context: context,
              msg: 'تم الغاء الطلب بنجاح',
              isDone: true,
            );
            Navigator.pop(context);
          } else if (state is DeleteRequestFailure) {
            customSnackBar(
              context: context,
              msg: state.errMessage,
              isDone: false,
            );
          } else if (state is CreateChatSuccess) {
            customSnackBar(
              context: context,
              msg: 'تم إنشاء المحادثة بنجاح',
              isDone: true,
            );

            final offers = context.read<NotificationCubit>().offers;
            final acceptedOffer = offers.any((o) => o.status == 'accepted')
                ? offers.firstWhere((o) => o.status == 'accepted')
                : null;

            if (acceptedOffer != null) {
              Navigator.pushNamed(
                context,
                'SocketChatBody',
                arguments: {
                  'otherUserId': state.chat.offerUser.id,
                  // acceptedOffer.helperId,
                  'otherUserName': state.chat.offerUser.name,
                  // acceptedOffer.helperName,
                  'otherUserAvatar': state.chat.offerUser.image,
                  // acceptedOffer.helperImage,
                  'isHelper': false,
                  'requestId': state.chat.helpRequest,
                  //  acceptedOffer.request,
                  'offerId': acceptedOffer.id,
                  'averageRating': acceptedOffer.averageRating,
                  'chatId': state.chat.id,
                },
              );
            }
          } else if (state is CreateChatFailure) {
            customSnackBar(
              context: context,
              msg: state.errMessage,
              isDone: false,
            );
          }
        },
        builder: (newContext, state) {
          final bool hasAcceptedOffer =
              state is NotificationSuccess &&
              state.offers.any((offer) => offer.status == 'accepted');
          return Scaffold(
            bottomSheet: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomElevatedButton(
                    text: 'عرض تفاصيل الطلب',
                    radius: CustomRadius.card12,
                    fun: () {
                      Navigator.pushNamed(
                        newContext,
                        'RequestDetails',
                        arguments: requests.first,
                      );
                    },
                    backgColor: AppColors.blueNormal,
                    foregColor: AppColors.whiteLight,
                    height: 48,
                    fontStyle: TextStyles.cairoBold16,
                  ),
                  SizedBox(height: 8.h),
                  if (!hasAcceptedOffer && requests.first.status != 'accepted')
                    CustomElevatedButton(
                      text: 'الغاء الطلب',
                      radius: CustomRadius.card12,
                      fun: () {
                        newContext.read<NotificationCubit>().deleteRequest(
                          requestId: requests.first.id,
                        );
                      },
                      backgColor: AppColors.redLightActive,
                      foregColor: AppColors.redDark,
                      height: 48,
                      fontStyle: TextStyles.cairoBold16,
                    ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            body: CustomScrollViewWithAppBar(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'العروض المتاحة',
                      style: TextStyles.cairoBold20.copyWith(
                        color: AppColors.blueNormal,),),
                        // SizedBox(height: 20.h),
                     if (!hasAcceptedOffer &&
                        requests.first.status != 'accepted')
                      _buildLoadingHeader(newContext, requests),
                    // SizedBox(height: 20.h),
                    BlocBuilder<NotificationCubit, NotificationState>(
                      buildWhen: (previous, current) =>
                          current is NotificationLoading ||
                          current is NotificationSuccess ||
                          current is NotificationFailure,
                      builder: (context, state) {
                        if (state is NotificationSuccess) {
                          final acceptedOffer =
                              state.offers.any((o) => o.status == 'accepted')
                              ? state.offers.firstWhere(
                                  (o) => o.status == 'accepted',
                                )
                              : null;

                          if (acceptedOffer != null) {
                            return Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: RequestOfferCard(
                                isOffline:
                                    requests.first.requestType == 'offline',
                                offerModel: acceptedOffer,
                                request: requests.first,
                                isAccepted: true,
                              ),
                            );

                            // Column(
                            //   children: [
                            //     SizedBox(height: 50.h),
                            //     Center(
                            //       child: Text(
                            //         'تم قبول عرض ${acceptedOffer.helperName}',
                            //         style: TextStyles.cairoBold16.copyWith(
                            //           color: AppColors.blueNormal,
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(height: 20.h),
                            //     CustomElevatedButton(
                            //       text: 'الذهاب للدردشة',
                            //       radius: CustomRadius.card12,
                            //       fun: () {
                            //         Navigator.pushNamed(
                            //           context,
                            //           'HelpOffline',
                            //           arguments: [
                            //             requests.first,
                            //             acceptedOffer,
                            //             false,
                            //           ],
                            //         );
                            //       },
                            //       backgColor: AppColors.greenNormal,
                            //       foregColor: AppColors.whiteLight,
                            //       height: 48,
                            //       fontStyle: TextStyles.cairoBold16,
                            //     ),
                            //   ],
                            // );
                          }

                          return _buildContent(
                            context,
                            state.offers
                                .where((offer) => offer.status == 'pending')
                                .toList(),
                            false,
                            requests,
                          );
                        } else if (state is NotificationFailure) {
                          return Center(child: Text(state.errMessage));
                        }
                        return _buildContent(
                          context,
                          _getDummyOffers(),
                          true,
                          requests,
                        );
                      },
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<OfferModel> offers,
    bool isLoading,
    List<RequestModel> requests,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      child: offers.isEmpty
          ? Column(
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    'لا توجد عروض',
                    style: TextStyles.cairoBold16.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            )
          : ListView.separated(
              padding: EdgeInsets.only(bottom: 20.h),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: offers.length,
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemBuilder: (context, index) => RequestOfferCard(
                isOffline: requests.first.requestType == 'offline',
                offerModel: offers[index],
              ),
            ),
    );
  }

  List<OfferModel> _getDummyOffers() {
    return List.generate(
      3,
      (index) => OfferModel(
        id: index,
        request: 0,
        helperName: 'محمد أحمد',
        helperImage: '',
        distance: '1.5',
        averageRating: '4.5',
        estimatedMinutes: '10',
        status: 'pending',
        createdAt: DateTime.now().toIso8601String(),
        helperId: 0,
        helperVerified: true,
        memberSince: '2020',
        helperPhone: '01067235116',
      ),
    );
  }

  Widget _buildLoadingHeader(
    BuildContext context,
    List<RequestModel> requests,
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top:10.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.blueGrey,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 6.r,
                  backgroundColor: AppColors.yellowNormal,
                ),
                SizedBox(width: 8.w),
                // const Spacer(),
                Text(
                  'جاري استقبال العروض المتاحة...',
                  style: TextStyles.cairoBold13.copyWith(
                    color: AppColors.blueDark,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),

        InkWell(
          borderRadius: CustomRadius.circle,
          onTap: () {
            context.read<NotificationCubit>().getOffers(
              requestId: requests.first.id,
            );
          },
          child: Icon(
            Icons.loop_rounded,
            color: AppColors.yellowNormal,
            size: 28.sp,
          ),
        ),
      ],
    );
  }
}
