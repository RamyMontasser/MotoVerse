import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class QuickOption extends StatelessWidget {
  const QuickOption({super.key, required this.title, required this.iconPath, required this.fun});

  final String title;
  final String iconPath;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        // height: 98.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: CustomRadius.card,
          color: AppColors.whiteNormal,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(50),
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            SizedBox(width: 15.w,),
            Expanded(
              child: Text(
                title,
                style: TextStyles.cairoBold13.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}