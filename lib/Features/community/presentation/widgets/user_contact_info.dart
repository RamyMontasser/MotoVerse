import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/notification_cubit.dart';
// import 'package:motoverse/Features/community/domain/entities/request_entity.dart';

class UserContactInfo extends StatelessWidget {
  final RequestModel request;
  final OfferModel offer;
  final bool isHelper;
  const UserContactInfo({super.key, required this.request, required this.offer, required this.isHelper});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: CustomRadius.card12,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDarker.withAlpha(30),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: AppColors.blueLight,
                    backgroundImage: isHelper?
                        request.userImage != null &&
                            request.userImage!.isNotEmpty
                        ? NetworkImage(
                            request.userImage!.startsWith('http')
                                ? request.userImage!
                                : "${AppConstants.baseUrl}${request.userImage!}",
                          )
                        : null
                        : offer.helperImage != null &&
                              offer.helperImage!.isNotEmpty
                        ? NetworkImage(
                            offer.helperImage!.startsWith('http')
                                ? offer.helperImage!
                                : "${AppConstants.baseUrl}${offer.helperImage!}",
                          )
                        : null,
                    child: isHelper?
                        request.userImage == null || request.userImage!.isEmpty
                        ? const Icon(Icons.person)
                        : null
                        : offer.helperImage == null || offer.helperImage!.isEmpty
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  CircleAvatar(
                    radius: 9.r,
                    backgroundColor: AppColors.blueLight,
                    // backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 2.h,
                      ),
                      child: Icon(
                        Icons.verified_outlined,
                        color: Colors.blue,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHelper
                    ? request.userName
                    : offer.helperName,
                    style: TextStyles.cairoBold14.copyWith(
                      color: AppColors.blueNormal,
                      height: 2.h,
                    ),
                  ),
                  Text(
                    "عضو منذ ${isHelper ? request.memberSince : offer.memberSince}",
                    style: TextStyles.cairoRegular11.copyWith(
                      color: AppColors.whiteDarkActive,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteLight,
                  borderRadius: CustomRadius.r20,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blueDarker.withAlpha(30),
                      spreadRadius: 0,
                      blurRadius: 2,
                      // offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_outline,
                      color: AppColors.yellowNormal,
                      size: 16.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      isHelper
                      // ?'3.5'
                      ? request.averageRating
                      : offer.averageRating,
                      style: TextStyles.cairoBold12.copyWith(
                        color: AppColors.blueDarkActive,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 20, color: AppColors.blueLight),

          if(offer.status == 'accepted')
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: 'اتصال',
                  radius: CustomRadius.card12,
                  fun: () {},
                  height: 45,
                  fontStyle: TextStyles.cairoBold16,
                  prefixIcon: Icon(
                    Icons.call_outlined,
                    size: 20,
                    color: AppColors.blueNormal,
                  ),
                  backgColor: AppColors.blueGrey,
                  foregColor: AppColors.blueDark,
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: CustomElevatedButton(
                  text: 'دردشة',
                  radius: CustomRadius.card12,
                  fun: () {
                    context.read<NotificationCubit>().enterChat(
                          requestId: request.id,
                        );
                  },
                  height: 45,
                  fontStyle: TextStyles.cairoBold16,
                  prefixIcon: Icon(
                    Icons.chat_bubble_outline_outlined,
                    size: 20,
                    color: AppColors.blueNormal,
                  ),
                  backgColor: AppColors.blueGrey,
                  foregColor: AppColors.blueNormal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
