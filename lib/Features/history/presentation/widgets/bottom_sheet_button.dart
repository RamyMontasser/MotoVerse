import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({super.key, required this.text, this.icon, this.fun, this.bgColor, this.foreColor});
  final String text;
  final IconData? icon;
  final Color? bgColor;
  final Color? foreColor;
  final VoidCallback? fun;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: AppColors.whiteLight,
      child: CustomElevatedButton(
        text: text ,
        radius: CustomRadius.r1,
        fun: fun,
        height: 53.h,
        withBorder: false,
        fontStyle: TextStyles.cairoBold16,
        backgColor: bgColor?? AppColors.yellowNormal,
        foregColor: foreColor?? AppColors.whiteNormal,
        suffixIcon:icon != null? Icon(icon, size: 20.w): null,
      ),
    );
  }
}
