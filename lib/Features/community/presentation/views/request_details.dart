import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/community/data/models/problem_type_model.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';
import 'package:motoverse/Features/community/presentation/cubit/offers_cubit.dart';
import 'package:motoverse/Features/community/presentation/cubit/requests_cubit.dart';
import 'package:motoverse/Features/community/presentation/widgets/member_info_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/problem_description_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/request_location_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/request_online_card.dart';
import 'package:motoverse/Features/history/presentation/widgets/bottom_sheet_button.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';
import 'package:motoverse/Features/home/presentation/cubit/notification_cubit.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';


class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestModel request =
        ModalRoute.of(context)!.settings.arguments as RequestModel;

    final userBox = Hive.box<UserDataModel>('user_box');
    final currentUser = userBox.get('user');
    final bool isMyRequest = currentUser?.id == request.userId;

    // debugPrint("request image ${request.images.first.image}");
    int imageNum = request.images.length;
    final List<ProblemTypeModel> problemTypes = [
      ProblemTypeModel(
        title: "بطارية",
        titleEnglish: "battery",
        iconPath: 'assets/icons/community/battery.svg',
      ),
      ProblemTypeModel(
        title: "محرك",
        titleEnglish: "engine",
        iconPath: 'assets/icons/community/motor.svg',
      ),
      ProblemTypeModel(
        title: "الإطارات",
        titleEnglish: "tires",
        iconPath: 'assets/icons/community/wheels.svg',
      ),
      ProblemTypeModel(
        title: "غير ذلك",
        titleEnglish: "other",
        iconPath: 'assets/icons/community/other.svg',
      ),
    ];

    final problemTypeModel = problemTypes.firstWhere(
      (element) =>
          element.title == request.problemType ||
          element.titleEnglish?.toLowerCase() ==
              request.problemType.toLowerCase(),
      orElse: () => problemTypes.last,
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollViewWithAppBar(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    request.requestType == 'online'
                        ? RequestOnlineCard(request: request)
                        : RequestLocationCard(request: request),

                    const SizedBox(height: 15),

                    ProblemDescriptionCard(
                      problemType: request.problemType,
                      description: request.description,
                      iconPath: problemTypeModel.iconPath,
                    ),

                    SizedBox(height: 10.h),

                    ListTile(
                      title: Text(
                        'الصور المرفقة',
                        style: TextStyles.cairoBold18.copyWith(
                          color: AppColors.blueDarkActive,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {},
                        child: Text(
                          '$imageNum صور',
                          style: TextStyles.cairoMedium12.copyWith(
                            color: AppColors.whiteDarker,
                          ),
                        ),
                      ),
                    ),

                    imageNum > 0
                        ? SizedBox(
                            height: 122.h,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: imageNum,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 10.w),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 149.w,
                                  child: ClipRRect(
                                    borderRadius: CustomRadius.card12,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) {
                                              return Scaffold(
                                                body: PhotoView(
                                                  imageProvider:
                                                      // AssetImage('assets/images/center.jpg',)
                                                      //   Image.asset(
                                                      //   fit: BoxFit.cover,
                                                      // ),
                                                      NetworkImage(
                                                        request
                                                                .images[index]
                                                                .image
                                                                .startsWith(
                                                                  'http',
                                                                )
                                                            ? request
                                                                  .images[index]
                                                                  .image
                                                            : AppConstants
                                                                      .baseUrl +
                                                                  request
                                                                      .images[index]
                                                                      .image,
                                                      ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child:
                                          //   Image.asset(
                                          //   'assets/images/center.jpg',
                                          //   fit: BoxFit.cover,
                                          // ),
                                          //  Image.network(request.images[index].image),
                                          Image.network(
                                            request.images[index].image
                                                    .startsWith('http')
                                                ? request.images[index].image
                                                : AppConstants.baseUrl +
                                                      request
                                                          .images[index]
                                                          .image,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.broken_image,
                                                  );
                                                },
                                          ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : SizedBox(height: 10.h),

                    SizedBox(height: 25.h),

                    isMyRequest
                        ? SizedBox.shrink()
                        : MemberInfoCard(
                            request: request,
                          ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
          if (request.status == 'pending')
          isMyRequest 
              ? BlocProvider(
                  create: (context) => NotificationCubit(getIt<HomeRepo>()),
                  child: BlocConsumer<NotificationCubit, NotificationState>(
                    listener: (context, state) {
                      if (state is DeleteRequestSuccess) {
                        context.read<RequestsCubit>().removeRequest(request.id);
                        Navigator.of(context).pop();
                        customSnackBar(
                          context: context,
                          msg: 'تم الغاء الطلب بنجاح',
                          isDone: true,
                        );
                      } else if (state is DeleteRequestFailure) {
                        customSnackBar(
                          context: context,
                          msg: state.errMessage,
                          isDone: false,
                        );
                      }
                    },
                    builder: (context, state) {
                      return BottomSheetButton(
                        text: 'الغاء الطلب',
                        bgColor: AppColors.redLightActive,
                        foreColor: AppColors.redDark,
                        fun: () {
                          context.read<NotificationCubit>().deleteRequest(requestId: request.id);
                        },
                      );
                    },
                  ),
                )
              :  BlocProvider(
    create: (context) => OffersCubit(communityRepo: getIt<CommunityRepo>()),
    child: BlocConsumer<OffersCubit, OffersState>(
      listener: (context, state) {
        if (state is MakeOfferSuccess) {
          customSnackBar(
            context: context,
            msg: 'تم تقديم عرض المساعدة بنجاح',
            isDone: true,
          );
          context.read<NavigationProvider>().changeIndex(0);
          Navigator.of(context).pushNamed('main screen');
        } 
        else if (state is MakeOfferFailure) {
          customSnackBar(
            context: context,
            msg: state.errorMsg, 
            isDone: false,
          );
        }
      },
      builder: (context, state) {
        return BottomSheetButton(
          text: state is MakeOfferLoading ? 'جاري إرسال العرض...' : 'تقديم المساعدة',
          bgColor: state is MakeOfferLoading ? AppColors.whiteDarker : AppColors.blueNormal,
          fun: state is MakeOfferLoading 
              ? () {} 
              : () {
                  // if (request.requestType == 'online') {
                    debugPrint(request.id.toString());
                    context.read<OffersCubit>().makeOffer(requestId: request.id);
                  // } else {
                    // Navigator.of(context).pushNamed('IdentityVarification');
                  // }
                },
        );
      },
    ),
  ),
        ],
      ),
    );
  }
}
