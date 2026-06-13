import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class LanguageSelectionCard extends StatelessWidget {
  final String langCode;
  final String title;
  final String subtitle;
  final String charBadge;
  final Color badgeBgColor;
  final Color badgeTextColor;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageSelectionCard({
    super.key,
    required this.langCode,
    required this.title,
    required this.subtitle,
    required this.charBadge,
    required this.badgeBgColor,
    required this.badgeTextColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.whiteLight,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.yellowNormal
                : AppColors.blueLightActive,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            
            Container(
              width: 47.w,
              height: 47.h,
              alignment: Alignment.center,
              // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: badgeBgColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                charBadge,
                style: TextStyles.cairoBold16.copyWith(color: badgeTextColor),
              ),
            ),

            SizedBox(width: 16.w),
            

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.cairoBold18.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyles.cairoRegular14.copyWith(
                      color: AppColors.whiteDarker,
                    ),
                  ),
                ],
              ),
            ),

            
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24.h,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.yellowNormal : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.yellowNormal
                      : AppColors.blueLightActive.withValues(alpha: 0.5),
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: AppColors.whiteLight,
                      size: 16,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
