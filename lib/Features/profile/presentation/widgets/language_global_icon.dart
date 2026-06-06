import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';

class LanguageGlobalIcon extends StatelessWidget {
  const LanguageGlobalIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.h,
      height: 120.h,
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.language_outlined,
          size: 50.sp,
          color: AppColors.blueNormal,
        ),
      ),
    );
  }
}
