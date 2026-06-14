import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

class CarModelCard extends StatelessWidget {
  final String carModel;


  const CarModelCard({
    super.key,
    required this.carModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).carModel,
            style: TextStyles.cairoBold16.copyWith(
              color: AppColors.blueDarkActive,
            ),
          ),
          SizedBox(height: 8.h,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.whiteNormal,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.directions_car_filled_outlined,
                  color: AppColors.blueDark,
                  size: 20.r,
                ),

                SizedBox(width: 8.w),

                Text(
                  carModel,
                  style: TextStyles.cairoBold16.copyWith(
                    color: AppColors.blueDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
  }

}