import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.error_outline,
    this.iconColor = AppColors.redNormal,
    this.iconBackgroundColor = AppColors.redLight,
    this.buttonLabel,
    this.onButtonPressed,
    this.padding,
  });

  final String title;
  final String? message;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 60.sp, color: iconColor),
            ),
            SizedBox(height: 18.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.cairoBold16.copyWith(
                color: AppColors.whiteDarkActive,
              ),
            ),
            if (message != null) ...[
              SizedBox(height: 10.h),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: TextStyles.cairoRegular14.copyWith(
                  color: AppColors.whiteDarkActive.withValues(alpha: 0.8),
                ),
              ),
            ],
            if (onButtonPressed != null && buttonLabel != null) ...[
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellowNormal,
                  foregroundColor: AppColors.blueDarkActive,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 26.w,
                    vertical: 12.h,
                  ),
                ),
                onPressed: onButtonPressed,
                child: Text(
                  buttonLabel!,
                  style: TextStyles.cairoBold14.copyWith(
                    color: AppColors.blueDarkActive,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
