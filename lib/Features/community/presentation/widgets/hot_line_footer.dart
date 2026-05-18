import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class HotLineFooter extends StatelessWidget {
  const HotLineFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Emergency? Call our direct hotline",
          style: TextStyles.cairoRegular14.copyWith(
            color: AppColors.whiteDarkActive,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          "1-800-AUTOCARE",
          style: TextStyles.cairoBold16.copyWith(
            color: AppColors.blueNormal,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}