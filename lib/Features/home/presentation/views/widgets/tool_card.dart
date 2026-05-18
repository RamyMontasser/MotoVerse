import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.iconPath,
    required this.name,
    // required this.small,
    this.desc,
    required this.fun, 
    required this.iconBgColor, 
    required this.iconColor,
  });
  // final String iconPath;
  final IconData iconPath;
  final String name;
  final Color iconBgColor;
  final Color iconColor;
  // final bool small;
  final String? desc;
  final Function() fun;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        width: 149.w,
        // height: 98.h,
        padding: EdgeInsets.symmetric(vertical: 18.h),
        // margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: CustomRadius.card,
          color: AppColors.whiteLight,
          border: BoxBorder.all(color: AppColors.whiteNormalActive, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(20),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SvgPicture.asset(iconPath, width: 40.w, height: 40.h),
            
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: CustomRadius.r1,
                color: iconBgColor,
              ),
              child: Center(child: Icon(iconPath, color: iconColor,fontWeight: FontWeight.w500,)),
            ),
            
            SizedBox(height: 6.h),

            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyles.cairoBold16.copyWith(
                color: AppColors.blueDarkActive,
              ),
            ),

            SizedBox(height: 7.h),

            desc != null
                ? Text(
                    desc!,
                    style: TextStyles.cairoRegular11.copyWith(
                      color: AppColors.whiteDarkActive,
                    ),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
