import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/history/data/models/car_history_model.dart';

class MaintenanceCard extends StatelessWidget {
  const MaintenanceCard({super.key, required this.historyModel});

  final CarHistoryModel historyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 42.h, bottom: 5.h),
      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 4.h, bottom: 8.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: CustomRadius.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.blueNormal,
                    size: 20.w,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    historyModel.centerName,
                    style: TextStyles.cairoMedium12.copyWith(
                      color: AppColors.blueDarker,
                    ),
                  ),
                ],
              ),

              IconButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  backgroundColor: AppColors.blueLight,
                  foregroundColor: AppColors.blueNormal,
                  shape: RoundedRectangleBorder(borderRadius: CustomRadius.r1),
                ),
                icon: Icon(Icons.phone_outlined, size: 18.w),
              ),
            ],
          ),

          // SizedBox(height: 5.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.w),
            decoration: BoxDecoration(
              color: AppColors.blueLight,
              borderRadius: CustomRadius.card,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  historyModel.service,
                  style: TextStyles.cairoBold12.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),

                SizedBox(height: 6.h),

                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.whiteDarker,
                      size: 15.sp,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      historyModel.date,
                      style: TextStyles.cairoRegular11.copyWith(
                        color: AppColors.whiteDarker,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                CustomElevatedButton(
                  text: 'تفاصيل الحجز',
                  radius: CustomRadius.circle,
                  fun: () {
                    Navigator.of(context).pushNamed('history2');
                  },
                  withBorder: false,
                  fontStyle: TextStyles.cairoBold12,
                  backgColor: AppColors.yellowNormal,
                  height: 23.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
