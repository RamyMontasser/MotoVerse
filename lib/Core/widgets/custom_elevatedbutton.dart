import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.radius,
    required this.fun,
    this.backgColor,
    this.foregColor,
    this.width,
    required this.height,
    this.borderColor,
    this.withBorder = false,
    this.prefixIconPath,
    this.suffixIconPath,
    required this.fontStyle,
    this.suffixIcon,
    this.prefixIcon,
    this.padding
  });

  final String text;
  final BorderRadius radius;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final VoidCallback? fun;
  final Color? backgColor;
  final Color? foregColor;
  final Color? borderColor;
  final double? width;
  final double height;
  final TextStyle fontStyle;
  final bool withBorder;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 5.w),
        backgroundColor: backgColor ?? AppColors.blueNormal,
        fixedSize: width != null
            ? Size(width!.w, height.h)
            : Size(double.infinity, height.h),

        // Size(310.w, 48.h),
        shape: RoundedRectangleBorder(
          side: withBorder
              ? BorderSide(color: borderColor ?? AppColors.blueNormal)
              : BorderSide.none,
          borderRadius: radius,
        ),
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIconPath != null
              ? Row(
                  children: [
                    Transform.flip(
                      flipX: isEN(),
                      child: SvgPicture.asset(
                        prefixIconPath!,
                        width: 24.w,
                        height: 24.h,
                        colorFilter: ColorFilter.mode(
                          foregColor ?? AppColors.whiteLight,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                  ],
                )
              : SizedBox(),

          prefixIcon != null
              ? Padding(
                  padding: EdgeInsetsGeometry.only(
                    right: isEN() ? 4 : 0,
                    left: isEN() ? 0 : 4,
                  ),
                  child: prefixIcon,
                )
              : SizedBox(),

          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: fontStyle.copyWith(
                color: foregColor ?? AppColors.whiteLight,
              ),
              //  fontFamily != null
              //     ? TextStyles.bold16Tajawal.copyWith(
              //         color: foregColor ?? AppColors.whiteLight,
              //       )
              // : TextStyles.cairoRegular16.copyWith(
              //     color: foregColor ?? AppColors.primaryBlueLight,
              //   ),
            ),
          ),

          suffixIconPath != null
              ? Row(
                  children: [
                    SizedBox(width: 2.w),
                    Transform.flip(
                      flipX: isEN(),
                      child: SvgPicture.asset(
                        suffixIconPath!,
                        width: 24.w,
                        height: 24.h,
                        colorFilter: ColorFilter.mode(
                          foregColor ?? AppColors.whiteLight,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),

          suffixIcon != null
              ? Padding(
                  padding: EdgeInsetsGeometry.only(
                    right: isEN() ? 0 : 12,
                    left: isEN() ? 12 : 0,
                  ),
                  child: suffixIcon,
                )
              : SizedBox(),
        ],
      ),
    );
  }

  // Widget suffixCreator() {
  //   if (suffixIconPath != null) {
  //     return Row(
  //       children: [
  //         SizedBox(width: 2.w),
  //         SvgPicture.asset(suffixIconPath!, width: 24.w, height: 24.h),
  //       ],
  //     );
  //   } else {
  //     return SizedBox();
  //   }
  // }

  // Widget prefixCreator() {
  //   if (prefixIconPath != null) {
  //     return Row(
  //       children: [
  //         SizedBox(width: 2.w),
  //         SvgPicture.asset(prefixIconPath!, width: 24.w, height: 24.h),
  //       ],
  //     );
  //   } else {
  //     return SizedBox();
  //   }
  // }
}

bool isEN() {
  return Intl.getCurrentLocale() == 'en';
}
