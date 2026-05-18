import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: CustomRadius.card12,
        border: Border.all(color: AppColors.blueLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تغيير اعتيادي لتيل الفرامل الأمامي. تم فحص طنابير الفرامل ووجد أنها في حالة جيدة. لا حاجة لخرط الطنابير في الوقت الحالي.",
            style: TextStyles.med13Tajawal.copyWith(color: AppColors.black),
          ),

          SizedBox(height: 15.h,),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.blueLightHover,
              borderRadius: CustomRadius.card12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.blueNormal,
                  size: 22.sp,
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ينصح بالفحص القادم خلال:",
                        style: TextStyles.med13Tajawal.copyWith(
                          color: AppColors.blueNormal,
                        ),
                      ),
                      Text(
                        "12,000 miles.",
                        style: TextStyles.med16Tajawal.copyWith(
                          color: AppColors.blueNormalActive,
                        ),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}