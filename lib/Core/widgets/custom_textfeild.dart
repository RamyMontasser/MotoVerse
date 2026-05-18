import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class CustomTextfeild extends StatelessWidget {
  const CustomTextfeild({
    super.key,
    required this.controller,
    this.hint,
    required this.obsecure,
    required this.keyboardType,
    this.suffex,
    this.prefex,
    this.backgColor,
    required this.radius,
    this.hintColor,
    required this.hasBorder,
    this.textStyle,
    this.label,
    this.maxlines = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String? hint;
  final bool obsecure;
  final TextInputType keyboardType;
  final Widget? suffex;
  final Widget? prefex;
  final Color? backgColor;
  final Color? hintColor;
  final TextStyle? textStyle;
  final BorderRadius radius;
  final bool hasBorder;
  final String? label;
  final int? maxlines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecure,
      keyboardType: keyboardType,
      cursorColor: AppColors.yellowNormal,
      maxLines: maxlines,
      style:
          textStyle ??
          TextStyles.cairoRegular16.copyWith(color: AppColors.blueNormal),
      decoration: InputDecoration(
        filled: true,
        fillColor: backgColor ?? AppColors.whiteNormal,
        labelText: label,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hint: Text(
          hint ?? '',
          style: TextStyles.cairoRegular14.copyWith(
            color: hintColor ?? AppColors.whiteDarkHover,
          ),
        ),
        suffixIcon: suffex,
        prefixIcon: prefex,
        border: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(strokeAlign: 20, color: AppColors.blueLightHover)
              : BorderSide.none,
          borderRadius: radius,
        ),
        focusedBorder: hasBorder
            ? OutlineInputBorder(
                borderRadius: CustomRadius.card12,
                borderSide: const BorderSide(
                  color: AppColors.blueNormalHover,
                  width: 1.5,
                ),
              )
            : null,
        errorBorder: OutlineInputBorder(
          borderRadius: CustomRadius.card12,
          borderSide: const BorderSide(color: AppColors.redNormal),
        ),
      ),
      validator: validator,
    );
  }
}
