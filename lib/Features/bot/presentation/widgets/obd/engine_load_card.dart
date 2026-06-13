import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class EngineLoadCard extends StatelessWidget {
  final String title;
  final String value;
  final double? progress;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  const EngineLoadCard({
    super.key,
    required this.title,
    required this.value,
    this.progress,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: bgColor,
                    child: Icon(icon, color: iconColor),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    title,
                    style: TextStyles.cairoBold14.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
            ],
          ),
          if (progress != null) ...[
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.blueLight,
                color: AppColors.blueNormal,
                minHeight: 8.h,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
