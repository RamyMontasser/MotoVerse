import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:pinput/pinput.dart';

class OtpTextfeild extends StatelessWidget {
  const OtpTextfeild({super.key, required this.oncompleted});

  final Function(String) oncompleted;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 4,
        defaultPinTheme: PinTheme(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 65.h,
          width: 65.w,
          textStyle: TextStyles.cairoSemiBold16.copyWith(
            color: AppColors.blueDarkActive,
          ),
          decoration: BoxDecoration(
            color: AppColors.blueLight,
            borderRadius: CustomRadius.card,
            // border: Border(bottom: BorderSide(color: AppColors.whiteDarker, width: 2, ))
          ),
        ),
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // margin: const EdgeInsets.only(bottom: 9),
              width: 35.w,
              height: 2.h,
              color: AppColors.whiteDarker,
            ),
          ],
        ),
        focusedPinTheme: PinTheme(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 65.h,
          width: 65.w,
          decoration: BoxDecoration(
            color: AppColors.blueLightHover,
            borderRadius: CustomRadius.card,
            // border: Border(bottom: BorderSide(color: AppColors.whiteDarker, width: 2, ))
          ),
        ),

        onCompleted: oncompleted,
      ),
    );
  }
}
