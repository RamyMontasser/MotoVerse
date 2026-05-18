import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';

class CustomAppDialog extends StatelessWidget {
  const CustomAppDialog({
    super.key,
    this.onTap,
    this.onTap2,
    required this.title,
    required this.desc,
    this.btnText, this.btnText2,
  });

  final VoidCallback? onTap;
  final VoidCallback? onTap2;
  final String title;
  final String desc;
  final String? btnText;
  final String? btnText2;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyles.cairoBold16.copyWith(
                color: AppColors.blueNormal,
              ),
            ),
            Text(
              desc,
              style: TextStyles.cairoRegular14.copyWith(
                color: AppColors.whiteDarkActive,
              ),
            ),
            Row(
              children: [
                if (btnText != null && btnText!.isNotEmpty)
                  CustomElevatedButton(
                    text: btnText!,
                    fun: () {
                      onTap;
                      // Navigator.pushNamedAndRemoveUntil(context, 'main screen', (route) => false);
                    },
                    height: 48,
                    radius: BorderRadius.circular(12.r),
                    withBorder: false,
                    backgColor: AppColors.blueNormal,
                    foregColor: AppColors.whiteLight,
                    fontStyle: TextStyles.cairoBold16,
                  ),
                SizedBox(height: 8.h),
                if (btnText2 != null && btnText2!.isNotEmpty)
                  CustomElevatedButton(
                    text: btnText2!,
                    fun: () {
                      onTap2;
                    },
                    height: 48,
                    radius: BorderRadius.circular(12.r),
                    withBorder: false,
                    backgColor: AppColors.blueNormal,
                    foregColor: AppColors.whiteLight,
                    fontStyle: TextStyles.cairoBold16,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
