import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class LanguageNoticeBanner extends StatelessWidget {
  const LanguageNoticeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: CustomRadius.card,
      ),
      child: Row(
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: AppColors.blueNormal,
            size: 20.sp,
          ),
          SizedBox(width: 10.w  ),
          Expanded(
            child: Text(
              'سيتم تطبيق تغييرات اللغة فوراً على جميع الأقسام والخدمات.',
              style: TextStyles.cairoRegular14.copyWith(
                color: AppColors.blueNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
