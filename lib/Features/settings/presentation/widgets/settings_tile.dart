import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.desc,
    required this.fun,
  });

  final String title;
  final String desc;
  final String iconPath;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,

      // child: Container(
      //   height: 98.h,
      //   padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      //   margin: EdgeInsets.symmetric(vertical: 5.h),
      //   decoration: BoxDecoration(
      //     borderRadius: CustomRadius.card,
      //     color: AppColors.whiteLight,
      //     boxShadow: [
      //       BoxShadow(
      //         color: AppColors.black.withAlpha(50),
      //         blurRadius: 3,
      //         spreadRadius: 1,
      //         offset: const Offset(0, 2),
      //       ),
      //     ],
      //   ),
      // child: Row(
      //   children: [
      //     Container(
      //       width: 47.w,
      //       height: 53.h,
      //       decoration: BoxDecoration(
      //         borderRadius: CustomRadius.card,
      //         color: AppColors.blueLightHover,
      //       ),
      //       child: Center(child: SvgPicture.asset(iconPath)),
      //     ),

      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(title, style: TextStyles.cairoSemiBold16),
      //           Text(desc, style: TextStyles.cairoRegular14),
      //         ],
      //       ),
      //     ),

      //     Spacer(),

      //     Icon(Icons.arrow_forward_ios, size: 19.w),
      //   ],
      // ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        leading: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: CustomRadius.card,
            color: AppColors.blueLightHover,
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              color: AppColors.blueNormal,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
        title: Text(title, style: TextStyles.cairoSemiBold16),

        subtitle: Text(desc, style: TextStyles.cairoRegular14),

        trailing: Icon(Icons.arrow_forward_ios, size: 19.w),
      ),
    );
    // );
  }
}
