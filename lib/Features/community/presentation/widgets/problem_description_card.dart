import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class ProblemDescriptionCard extends StatelessWidget {
  const ProblemDescriptionCard({super.key, required this.problemType, required this.description, required this.iconPath});
  final String problemType;
  final String description;
  final String iconPath;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: CustomRadius.r20,
        border: Border.all(color: AppColors.whiteNormalActive),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDarker.withAlpha(30),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "تفاصيل المشكلة",
                style: TextStyles.cairoBold18.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              Spacer(),
              SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  AppColors.yellowNormal,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          const Divider(height: 30, color: AppColors.whiteNormalActive),
          Text(
            problemType,
            style: TextStyles.cairoBold18.copyWith(color: AppColors.blueNormal),
          ),
          SizedBox(height: 10.h),
          Text(
            description,
            style: TextStyles.cairoMedium12.copyWith(
              color: AppColors.whiteDarkActive,
              height: 1.5.h,
            ),
          ),
        ],
      ),
    );
  }
}
