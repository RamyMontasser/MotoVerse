import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';

class RequestOnlineCard extends StatelessWidget {
  const RequestOnlineCard({super.key, required this.request});

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: CustomRadius.r20,
        border: Border.all(color: AppColors.whiteNormalActive),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDarker.withAlpha(30),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.userName,
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueDarkActive,
                ),
              ),
              Text(
                request.city,
                style: TextStyles.cairoRegular11.copyWith(
                  color: AppColors.whiteDarkActive,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.yellowLight,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "مساعدة أونلاين",
              style: TextStyles.bold11Tajawal.copyWith(
                color: AppColors.yellowNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
