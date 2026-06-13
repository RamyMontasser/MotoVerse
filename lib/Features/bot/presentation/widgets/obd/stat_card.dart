import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double? progress;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
          CircleAvatar(
            backgroundColor: AppColors.blueLight,
            child: Icon(icon, color: AppColors.blueNormal),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyles.cairoBold18.copyWith(color: AppColors.blueNormal),
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyles.cairoMedium12.copyWith(
              color: AppColors.whiteDarker,
            ),
          ),
          if (progress != null) ...[
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.blueLight,
                color: AppColors.blueNormal,
                minHeight: 6.h,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
