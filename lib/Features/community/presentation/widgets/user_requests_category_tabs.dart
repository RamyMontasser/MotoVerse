import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

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
      {'title': S.of(context).all, 'color': AppColors.blueNormal},
      {'title': S.of(context).active, 'color': AppColors.greenNormal},
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
                end: index == categories.length - 1 ? 0 : 8.w,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected ? color : AppColors.whiteLight,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected ? color : AppColors.blueLightActive,
                  width: 1,
                ),
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
