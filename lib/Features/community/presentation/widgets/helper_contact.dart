import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

class HelperContact extends StatelessWidget {
  final String helperName;
  final String averageRating;
  final String? helperAvatar;

  const HelperContact({
    super.key,
    required this.helperName,
    required this.averageRating,
    required this.helperAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: CustomRadius.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.25),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundColor: AppColors.blueLight,
                backgroundImage: helperAvatar?.isNotEmpty == true
                    ? NetworkImage(helperAvatar!)
                    : null,
                child: helperAvatar?.isNotEmpty == true
                    ? null
                    : const Icon(Icons.person, color: AppColors.blueNormal),
              ),
              CircleAvatar(
                radius: 8.r,
                backgroundColor: AppColors.whiteLight,
                child: Icon(Icons.verified, color: Colors.blue, size: 14.sp),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  helperName.isNotEmpty
                      ? helperName
                      : S.of(context).defaultHelperName,
                  style: TextStyles.cairoBold14.copyWith(
                    color: AppColors.blueNormal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  S
                      .of(context)
                      .currentRating(
                        averageRating.isNotEmpty
                            ? averageRating
                            : S.of(context).ratingNotAvailable,
                      ),
                  style: TextStyles.cairoRegular11.copyWith(
                    color: AppColors.whiteDarkHover,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.whiteLight,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: AppColors.yellowNormal, size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  averageRating.isNotEmpty ? averageRating : "0.0",
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
