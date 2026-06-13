import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class StatCard2 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard2({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
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
            color: AppColors.black.withValues(alpha: 0.1),
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
            title,
            textAlign: TextAlign.center,
            style: TextStyles.cairoMedium12.copyWith(
              color: AppColors.blueDarkHover,
            ),
          ),

          SizedBox(height: 2.h),

          Text(
            value,
            style: TextStyles.cairoBold18.copyWith(color: AppColors.blueNormal),
          ),
        ],
      ),
    );
  }
}
