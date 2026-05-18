import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class OldChats extends StatelessWidget {
  const OldChats({
    super.key,
    required this.title,
    required this.iconPath,
    required this.date,
    required this.time,
    required this.fun,  
  });

  final String title;
  final String date;
  final String time;
  final String iconPath;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        // height: 98.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: CustomRadius.card,
          color: AppColors.whiteNormal,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(50),
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 45.w,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: CustomRadius.r1,
                color: AppColors.blueLightHover,
              ),
              child: Center(child: SvgPicture.asset(iconPath)),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyles.cairoBold13.copyWith(color: AppColors.blueNormal)),
                  SizedBox(height: 5.h,),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.whiteDarker,
                        size: 15.sp,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "$time  • ",
                        style: TextStyles.cairoRegular11.copyWith(
                          color: AppColors.whiteDarker,
                        ),
                      ),
                      Text(
                        " $date",
                        style: TextStyles.cairoRegular11.copyWith(
                          color: AppColors.whiteDarker,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Spacer(),

            Icon(Icons.arrow_forward_ios, size: 19.w),
          ],
        ),
      ),
    );
  }
}
