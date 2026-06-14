import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

class AiAnalysisCard extends StatelessWidget {
  final double? anomalyPercentage;
  final String? status;
  final bool isLoading;
  final String? errorMessage;

  const AiAnalysisCard({
    super.key,
    this.anomalyPercentage,
    this.status,
    this.isLoading = false,
    this.errorMessage,
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
          // Container(
          //   width: double.infinity,
          //   padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          //   decoration: BoxDecoration(
          //     color: AppColors.whiteNormal,
          //     borderRadius: BorderRadius.circular(24.r),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Icon(
          //         Icons.directions_car_filled_outlined,
          //         color: AppColors.blueDark,
          //         size: 20.r,
          //       ),

          //       SizedBox(width: 8.w),

          //       Text(
          //         carModel,
          //         style: TextStyles.cairoBold16.copyWith(
          //           color: AppColors.blueDark,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).aiAnalysis,
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueDarkActive,
                ),
              ),
              if (status != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: status == 'warning'
                        ? AppColors.redLight
                        : AppColors.greenLight,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        color: status == 'warning'
                            ? AppColors.redNormal
                            : AppColors.greenNormal,
                        size: 10.r,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        isEN()
                            ? status!
                            : status! == 'warning'
                            ? 'تحذير'
                            : 'طبيعي',
                        style: TextStyles.cairoBold11.copyWith(
                          color: status == 'warning'
                              ? AppColors.redNormal
                              : AppColors.greenNormal,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Loading skeleton
          if (isLoading) ...[
            Container(
              width: 180.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: AppColors.whiteNormal,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColors.whiteNormal,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ] else if (errorMessage != null) ...[
            Row(
              children: [
                Icon(Icons.error_outline, color: AppColors.redNormal),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    S.of(context).unsupportedCar,
                    // errorMessage!,
                    style: TextStyles.cairoRegular13.copyWith(
                      color: AppColors.redNormal,
                    ),
                  ),
                ),
              ],
            ),
          ] else if (anomalyPercentage != null) ...[
            Text(
              S.of(context).anomalyRatio(anomalyPercentage!),
              style: TextStyles.cairoBold13.copyWith(
                color: AppColors.blueDarkActive,
              ),
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: (anomalyPercentage!) / 100,
                backgroundColor: AppColors.whiteNormal,
                color: AppColors.yellowNormal,
                minHeight: 8.h,
              ),
            ),
            // SizedBox(height: 8.h),
            // if (status != null) ...[
            //   SizedBox(height: 8.h),
            //   Text(
            //     S.of(context).modelConfidence,
            //     style: TextStyles.cairoRegular11.copyWith(
            //       color: AppColors.whiteDark,
            //     ),
            //   ),
            // ],
          ] else ...[
            Text(
              'Waiting for AI analysis...',
              style: TextStyles.cairoRegular13.copyWith(
                color: AppColors.whiteDark,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

bool isEN() {
  return Intl.getCurrentLocale() == 'en';
}
