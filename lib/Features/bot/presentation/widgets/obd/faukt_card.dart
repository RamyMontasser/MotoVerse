import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

class FaultCard extends StatelessWidget {
  final String faultCode;

  const FaultCard({super.key, required this.faultCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border(
          right: Directionality.of(context) == TextDirection.rtl
              ? BorderSide(color: AppColors.redDark, width: 4.w)
              : BorderSide.none,
          left: Directionality.of(context) == TextDirection.ltr
              ? BorderSide(color: AppColors.redDark, width: 4.w)
              : BorderSide.none,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                S.of(context).faultDetected,
                style: TextStyles.cairoMedium14.copyWith(
                  color: AppColors.blueDarkActive,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                faultCode,
                style: TextStyles.cairoBold32.copyWith(
                  color: AppColors.redDark,
                  height: 1.1,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.redLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: AppColors.redDark,
              size: 28.r,
            ),
          ),
        ],
      ),
    );
  }
}
