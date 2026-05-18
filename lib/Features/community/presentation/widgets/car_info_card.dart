import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class CarInfoCard extends StatelessWidget {
  const CarInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteLight,
                  borderRadius: CustomRadius.r20,
                  border: Border.all(color: AppColors.blueLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'العربية',
                                style: TextStyles.cairoMedium12.copyWith(
                                  color: AppColors.whiteDarker,
                                ),
                              ),
                              Text(
                                'تويوتا كامري 2022',
                                style: TextStyles.cairoBold16.copyWith(
                                  color: AppColors.blueNormal,
                                  height: 2.h,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blueGrey,
                            borderRadius: CustomRadius.r1,
                          ),
                          child: Icon(
                            Icons.car_crash_outlined,
                            size: 28.sp,
                            color: AppColors.yellowNormal,
                          ),
                        ),
                      ],
                    ),
                   
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.redLight,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.redNormal.withAlpha(30))
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error, color: AppColors.redNormal),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'المشكلة المبلغ عنها',
                                style: TextStyles.cairoRegular11.copyWith(
                                  color: AppColors.redNormal,
                                ),
                              ),
                              Text(
                                'عطل في المحرك',
                                style: TextStyles.cairoBold16.copyWith(
                                  color: AppColors.blueDarkActive,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
  }
}