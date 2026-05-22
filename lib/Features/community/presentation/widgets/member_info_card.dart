import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';

class MemberInfoCard extends StatelessWidget {
  const MemberInfoCard({super.key, required this.request});
  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteNormal,
        borderRadius: CustomRadius.card12,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDarker.withAlpha(30),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 6),
          ),
        ],
        // border: Border.all(color: AppColors.whiteNormalActive),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundColor: AppColors.blueLight,
                backgroundImage:
                    request.userImage != null && request.userImage!.isNotEmpty
                    ? NetworkImage(
                        request.userImage!.startsWith('http')
                            ? request.userImage!
                            : "${AppConstants.baseUrl}${request.userImage!}",
                      )
                    : null,
                child: request.userImage == null || request.userImage!.isEmpty
                    ? const Icon(Icons.person)
                    : null,
              ),
              CircleAvatar(
                radius: 8.r,
                backgroundColor: AppColors.blueLight,
                // backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
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
            children: [
              Text(
                request.userName,
                style: TextStyles.cairoBold13.copyWith(
                  color: AppColors.blueDarkActive,
                  height: 2.h,
                ),
              ),
              Text(
                "عضو منذ ${request.memberSince}",
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
                  "4.8",
                  style: TextStyles.cairoBold12.copyWith(
                    color: AppColors.blueDarkActive,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
