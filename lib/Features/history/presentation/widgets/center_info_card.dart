import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';

class CenterInfoCard extends StatelessWidget {
  const CenterInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    int reviewsNum = 120;
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: CustomRadius.card12,
        border: Border.all(color: AppColors.blueLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(70),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 106.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: CustomRadius.r1),
            child: Image.asset('assets/images/center.jpg', fit: BoxFit.cover),
          ),

          SizedBox(height: 10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "مركز الماسة للصيانة",
                style: TextStyles.cairoSemiBold16.copyWith(
                  color: AppColors.blueDarkHover,
                ),
              ),
              Row(
                children: [
                  Text(
                    "($reviewsNum+ تقييم) ",
                    style: TextStyles.cairoRegular11.copyWith(
                      color: AppColors.whiteDarkHover,
                    ),
                  ),
                  Text(
                    " 4.8 ",
                    style: TextStyles.med13Tajawal.copyWith(
                      color: AppColors.blueDarkHover,
                    ),
                  ),
                  Icon(Icons.star, color: AppColors.yellowNormal, size: 16.w),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.whiteDarkActive,
                    size: 16.w,
                  ),
                  Text(
                    "القاهرة , مصر",
                    style: TextStyles.cairoRegular14.copyWith(
                      color: AppColors.whiteDarkActive,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 9.h,
                    ),
                    backgroundColor: AppColors.blueNormal,
                    foregroundColor: AppColors.blueLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: CustomRadius.r1,
                    ),
                  ),
                  icon: Icon(Icons.phone_outlined, size: 24.w),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 5,
                child: CustomElevatedButton(
                  text: 'احجز مرة آخري',
                  radius: CustomRadius.r1,
                  fun: () {},
                  height: 42.h,
                  withBorder: false,
                  fontStyle: TextStyles.cairoBold13,
                  backgColor: AppColors.blueLight,
                  foregColor: AppColors.blueNormal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
