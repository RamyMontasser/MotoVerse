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
import 'package:motoverse/Features/community/presentation/widgets/car_info_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/request_location_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/user_contact_info.dart';
import 'package:motoverse/Features/home/data/models/offer_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';
import 'package:motoverse/Features/home/presentation/cubit/my_offers_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/notification_cubit.dart';
import 'package:motoverse/Features/socket_chat/data/models/chat_arguments.dart';

class HelpOffline extends StatelessWidget {
  const HelpOffline({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List;
    final RequestModel request = args[0];
    final OfferModel offer = args[1];
    final bool isHelper = args[2];
    // final String status = args[1];
    // final int offerId = args[2];

    Color statusColor;
    Color statusLightColor;
    String statusText;

    switch (offer.status) {
      case 'accepted':
        statusColor = AppColors.greenNormal;
        statusLightColor = AppColors.greenLight;
        statusText = 'تم قبول هذا العرض';
        break;
      case 'rejected':
        statusColor = AppColors.orangeNormal;
        statusLightColor = AppColors.orangeLight;
        statusText = 'تم الغاء هذا العرض';
        break;
      case 'completed':
        statusColor = AppColors.blueNormal;
        statusLightColor = AppColors.blueLight;
        statusText = 'تم اكمال هذا العرض';
        break;
      case 'pending':
      default:
        statusColor = AppColors.redDark;
        statusLightColor = AppColors.redLight;
        statusText = 'الغاء عرض المساعدة';
        break;
    }

    final displayRequest = request;
    // ??
    //     RequestModel(
    //       id: 0,
    //       userId: 0,
    //       userImage: '',
    //       userName: '',
    //       memberSince: 2024,
    //       city: '',
    //       description: '',
    //       problemType: '',
    //       requestType: '',
    //       images: [],
    //       imagesCount: 0,
    //       status: '',
    //       createdAt: '',
    //       distance: 2.5,
    //     );

    return BlocProvider(
      create: (context) => NotificationCubit(getIt<HomeRepo>()),
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is CreateChatLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: AppColors.blueNormal),
              ),
            );
          } else if (state is CreateChatSuccess) {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              'SocketChat',
              arguments: ChatArguments(
                chatId: state.chat.id.toString(),
                chatUserId: isHelper
                    ? state.chat.requestUser.id.toString()
                    : offer.helperId.toString(),
                chatUserName: isHelper
                    ? (state.chat.requestUser.name)
                    : (offer.helperName),
                helperAvatar: isHelper
                    ? state.chat.requestUser.image
                    : offer.helperImage,
                isHelper: isHelper,
                requestId: isHelper
                    ? state.chat.id.toString()
                    : request.id.toString(),
                offerId: offer.id.toString(),
                averageRating: offer.averageRating.toString(),
                helperVerified: offer.helperVerified,
                isOnline: isHelper
                    ? state.chat.requestUser.isOnline
                    : state.chat.offerUser.isOnline,
              ),
            );
          } else if (state is CreateChatFailure) {
            Navigator.pop(context);
            customSnackBar(
              context: context,
              msg: state.errMessage,
              isDone: false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollViewWithAppBar(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: request.requestType == 'offline'
                            ? AppColors.blueLight
                            : AppColors.yellowLight,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        request.requestType == 'offline'
                            ? ' مساعدة اوفلاين'
                            : ' مساعدة اونلاين',
                        style: TextStyles.cairoBold12.copyWith(
                          color: request.requestType == 'offline'
                              ? AppColors.blueNormal
                              : AppColors.yellowNormal,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    displayRequest.requestType == 'offline'
                        ? RequestLocationCard(
                            isAccepted: true,
                            request: displayRequest,
                            offer: offer,
                            // isOfferSent: true,
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 15.h),

                    UserContactInfo(
                      request: displayRequest,
                      offer: offer,
                      isHelper: isHelper,
                    ),

                    SizedBox(height: 20.h),

                    CarInfoCard(problemType: displayRequest.problemType),

                    SizedBox(height: 20.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueGrey,
                        borderRadius: CustomRadius.r1,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: 16.sp,
                            color: AppColors.blueNormal,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'جميع تفاصيل العميل والبيانات الشخصية محمية ومؤمنة .',
                            style: TextStyles.cairoRegular11.copyWith(
                              color: AppColors.blueNormal,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),
                    if (offer.status != 'accepted')
                      CustomElevatedButton(
                        text: statusText,
                        radius: CustomRadius.card12,
                        fun: () {
                          if (offer.status == 'accepted') {
                            context.read<NotificationCubit>().enterChat(
                              requestId: request.id,
                            );
                          } else if (offer.status == 'pending') {
                            debugPrint(offer.id.toString());
                            context.read<MyOffersCubit>().deleteOffer(
                              offerId: offer.id,
                            );
                            Navigator.pop(context);
                          }
                        },
                        backgColor: statusLightColor,
                        foregColor: statusColor,
                        height: 50,
                        fontStyle: TextStyles.cairoBold16,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
