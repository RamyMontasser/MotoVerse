import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class UserRequestsCategoryTabs extends StatelessWidget {
  const UserRequestsCategoryTabs({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'title': 'الكل', 'color': AppColors.blueNormal},
      {'title': 'نشطة', 'color': AppColors.greenNormal},
    ];

    return Row(
      children: List.generate(categories.length, (index) {
        final isSelected = selectedIndex == index;
        final category = categories[index];
        final color = category['color'] as Color;

        return Expanded(
          child: GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              margin: EdgeInsetsDirectional.only(
                start: index == 8.w ? 0 : 0,
                end: index == categories.length - 1 ? 0 : 8.w,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              // height: 40.h,
              decoration: BoxDecoration(
                color: isSelected ? color : AppColors.whiteLight,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected ? color : AppColors.blueLightActive,
                  width: 1,
                ),
                // boxShadow: isSelected
                //     ? [
                //         BoxShadow(
                //           color: color.withValues(alpha: 0.2),
                //           blurRadius: 2,
                //           offset: const Offset(0, 2),
                //         ),
                //       ]
                //     : null,
              ),
              child: Center(
                child: Text(
                  category['title'] as String,
                  style: TextStyles.cairoRegular14.copyWith(
                    color: isSelected
                        ? AppColors.whiteLight
                        : AppColors.blueDarkActive,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  bool isEN() {
    return Intl.getCurrentLocale() == 'en';
  }
}
