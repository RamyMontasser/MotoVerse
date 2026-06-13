import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';


class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailingText,
    this.trailingTextColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final String? trailingText;
  final Color? trailingTextColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
        child: Row(
          children: [
            Icon(icon, color: AppColors.whiteDarker, size: 22.sp),
            SizedBox(width: 10.w),

            Text(
              title,
              style: TextStyles.cairoRegular15.copyWith(
                color: AppColors.blueDarker,
              ),
            ),

            const Spacer(),

            if (trailingText != null)
              Text(
                '$trailingText ',
                style: TextStyles.cairoBold12.copyWith(
                  color: trailingTextColor,
                ),
              ),

            Icon(
              Icons.arrow_forward_ios,
              size: 12.sp,
              color: AppColors.whiteDarker,
            ),
          ],
        ),
      ),
    );
  }
}
