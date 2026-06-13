import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class ProblemTypeCard extends StatelessWidget {
  const ProblemTypeCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? AppColors.yellowNormal
        : AppColors.blueLight;
    final iconColor = isSelected
        ? AppColors.yellowNormal
        : AppColors.blueNormal;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
        decoration: BoxDecoration(
          color: AppColors.whiteLight,
          borderRadius: CustomRadius.card12,
          border: Border.all(color: borderColor, width: isSelected ? 2.w : 1.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              height: 27.h,
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: TextStyles.cairoBold13.copyWith(
                color: AppColors.blueDarkActive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
