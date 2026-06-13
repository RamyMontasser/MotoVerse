import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

class CarAnalysis extends StatelessWidget {
  const CarAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'ObdDashboardScreen');
      },
      borderRadius: CustomRadius.card12,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.whiteLight,
          borderRadius: CustomRadius.card12,
          border: Border.all(color: AppColors.whiteNormalHover),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.yellowLight,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: AppColors.yellowNormal,
                size: 30.sp,
              ),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).carDataAnalysis,
                    style: TextStyles.cairoBold16.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    S.of(context).smartVisionIndicators,
                    style: TextStyles.cairoRegular13.copyWith(
                      color: AppColors.whiteDarker,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: AppColors.whiteNormalHover,
            ),
          ],
        ),
      ),
    );
  }
}
