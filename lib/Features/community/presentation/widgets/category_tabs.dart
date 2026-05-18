import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key, required this.selectedIndex, required this.onTap});

  final int selectedIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final List<String> categories = ["الكل", "مساعدة نصية", "مساعدة مباشرة"];
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 5.w),
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Container(
              width: 111.w,
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.blueNormal : AppColors.whiteLight,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.blueLightActive),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index == 1
                        ? Icon(
                            Icons.message_outlined,
                            size: 12.sp,
                            color: isSelected
                                ? AppColors.whiteLight
                                : AppColors.blueDarkActive,
                          )
                        : SizedBox(),
                    index == 2
                        ? Icon(
                            Icons.location_on_outlined,
                            size: 12.sp,
                            color: isSelected
                                ? AppColors.whiteLight
                                : AppColors.blueDarkActive,
                          )
                        : SizedBox(),
                    SizedBox(width: index>0? 1.w: 0,),
                    Expanded(
                      child: Text(
                        categories[index],
                        textAlign: TextAlign.center,
                        style: TextStyles.cairoMedium12.copyWith(
                          color: isSelected
                              ? AppColors.whiteLight
                              : AppColors.blueDarkActive,
                        ),
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
