import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

class AiAnalysisCard extends StatelessWidget {
  final String carModel;
  final int anomalyPercentage;

  const AiAnalysisCard({
    super.key,
    required this.carModel,
    required this.anomalyPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).aiAnalysis,
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueDarkActive,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.yellowLight,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      color: AppColors.yellowNormal,
                      size: 10.r,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      S.of(context).statusNeedsFollowUp,
                      style: TextStyles.cairoBold11.copyWith(
                        color: AppColors.yellowNormal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.whiteNormal,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.directions_car_filled_outlined,
                  color: AppColors.blueDark,
                  size: 20.r,
                ),

                SizedBox(width: 8.w),

                Text(
                  carModel,
                  style: TextStyles.cairoBold16.copyWith(
                    color: AppColors.blueDark,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).anomalyRatio(anomalyPercentage),
                style: TextStyles.cairoBold13.copyWith(
                  color: AppColors.blueDarkActive,
                ),
              ),

              Text(
                S.of(context).modelConfidence,
                style: TextStyles.cairoRegular11.copyWith(
                  color: AppColors.whiteDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: anomalyPercentage / 100,
              backgroundColor: AppColors.whiteNormal,
              color: AppColors.yellowNormal,
              minHeight: 8.h,
            ),
          ),
        ],
      ),
    );
  }
}
