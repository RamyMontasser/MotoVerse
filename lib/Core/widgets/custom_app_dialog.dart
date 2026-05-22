import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';

class CustomAppDialog extends StatelessWidget {
  const CustomAppDialog({
    super.key,
    this.onTap,
    this.onTap2,
    required this.title,
    required this.desc,
    this.btnText,
    this.btnText2, this.icon, this.iconBgColor,
  });

  final VoidCallback? onTap;
  final VoidCallback? onTap2;
  final String title;
  final String desc;
  final String? btnText;
  final String? btnText2;
  final Icon? icon;
  final Color? iconBgColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteLight,
      shape: RoundedRectangleBorder(borderRadius: CustomRadius.card),
      elevation: 8,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon != null)...[
              CircleAvatar(
                backgroundColor: AppColors.greenLight,
                radius: 30.r,
                child: icon,
              ),
              // icon!,
              SizedBox(height: 12.h,),],
            Text(
              title,
              style: TextStyles.cairoBold18.copyWith(
                color: AppColors.blueNormal,
              ),
            ),
            SizedBox(height: 10.h,),
            Text(
              desc,
              style: TextStyles.cairoRegular16.copyWith(
                color: AppColors.whiteDarkActive,
              ),
            ),
            SizedBox(height: 20.h,),
            btnText2 == null 
                ? btnText != null && btnText!.isNotEmpty
                      ? CustomElevatedButton(
                          text: btnText!,
                          fun: () {
                            onTap?.call();
                            // Navigator.pushNamedAndRemoveUntil(context, 'main screen', (route) => false);
                          },
                          height: 48,
                          radius: BorderRadius.circular(12.r),
                          withBorder: false,
                          backgColor: AppColors.blueNormal,
                          foregColor: AppColors.whiteLight,
                          fontStyle: TextStyles.cairoBold16,
                        )
                      : SizedBox()
                : Row(
                    children: [
                      if (btnText != null && btnText!.isNotEmpty)
                        Expanded(
                          child: CustomElevatedButton(
                            text: btnText!,
                            fun: () {
                              onTap?.call();
                              // Navigator.pushNamedAndRemoveUntil(context, 'main screen', (route) => false);
                            },
                            height: 48,
                            radius: BorderRadius.circular(12.r),
                            withBorder: false,
                            backgColor: AppColors.blueNormal,
                            foregColor: AppColors.whiteLight,
                            fontStyle: TextStyles.cairoBold16,
                          ),
                        ),
                      SizedBox(width: 8.w),
                      if (btnText2 != null && btnText2!.isNotEmpty)
                        Expanded(
                          child: CustomElevatedButton(
                            text: btnText2!,
                            fun: () {
                              onTap2?.call();
                            },
                            height: 48,
                            radius: BorderRadius.circular(12.r),
                            withBorder: false,
                            backgColor: AppColors.blueNormal,
                            foregColor: AppColors.whiteLight,
                            fontStyle: TextStyles.cairoBold16,
                          ),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
