import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class AiToggleButtons extends StatelessWidget {
  final bool isExplainProblemSelected;
  final ValueChanged<bool> onToggleChanged;

  const AiToggleButtons({
    super.key,
    required this.isExplainProblemSelected,
    required this.onToggleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            alignment: isExplainProblemSelected
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.48,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.blueNormal,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onToggleChanged(true),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyles.cairoBold13.copyWith(
                        color: !isExplainProblemSelected
                            ? AppColors.whiteDarker
                            : AppColors.whiteLight,
                      ),
                      child: const Text('اشرح المشكلة'),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => onToggleChanged(false),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyles.cairoBold13.copyWith(
                        color: isExplainProblemSelected
                            ? AppColors.whiteDarker
                            : AppColors.whiteLight,
                      ),
                      child: const Text('فحص الأعطال (OBD)'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
