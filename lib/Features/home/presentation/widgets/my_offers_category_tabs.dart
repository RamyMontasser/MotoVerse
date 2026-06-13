import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

class MyOffersCategoryTabs extends StatelessWidget {
  const MyOffersCategoryTabs({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    // تم النقل داخل الـ build لتمكين جلب النصوص المترجمة فورياً عند تغيير لغة التطبيق
    final List<Map<String, dynamic>> categories = [
      {'title': S.of(context).all, 'color': AppColors.blueNormal},
      {'title': S.of(context).accepted, 'color': AppColors.greenNormal},
      {'title': S.of(context).pending, 'color': AppColors.yellowNormal},
      {'title': S.of(context).completed, 'color': AppColors.blueNormal},
      {'title': S.of(context).rejected, 'color': AppColors.redDark},
    ];

    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          final category = categories[index];
          final color = category['color'] as Color;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 40.h,
              decoration: BoxDecoration(
                color: isSelected ? color : AppColors.whiteLight,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected ? color : AppColors.blueLightActive,
                  width: 1,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category['title'] as String,
                      style: TextStyles.cairoMedium12.copyWith(
                        color: isSelected
                            ? AppColors.whiteLight
                            : AppColors.blueDarkActive,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
