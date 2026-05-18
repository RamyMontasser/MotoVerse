import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/auth/presentation/cubit/send_otp_cubit.dart';
import 'package:motoverse/Features/auth/presentation/cubit/verify_otp_cubit.dart';
import 'package:motoverse/Features/auth/presentation/views/widgets/otp_textfeild.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:provider/provider.dart';

class OtpPageBody extends StatefulWidget {
  const OtpPageBody({super.key, required this.phoneNum});
  final String phoneNum;

  @override
  State<OtpPageBody> createState() => _OtpPageBodyState();
}

class _OtpPageBodyState extends State<OtpPageBody> {
  String otpCode = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo1.svg',
              height: 60.h,
              width: 110.w,
            ),

            SizedBox(height: 20.h),

            Text(
              S.of(context).confirmPhoneTitle,
              style: TextStyles.cairoBold32.copyWith(
                color: AppColors.blueDarker,
              ),
            ),

            Text(
              textAlign: TextAlign.center,
              S.of(context).otpSentMessage(widget.phoneNum),
              style: TextStyles.cairoRegular16.copyWith(
                color: AppColors.whiteDarker,
              ),
            ),

            // RichText(
            //   textAlign: TextAlign.center,
            //   text: TextSpan(
            //     children: [
            //       TextSpan(
            //         text: 'لقد قمنا باسال رمز التأكيد لرقم    ',
            //         style: TextStyles.cairoRegular16.copyWith(
            //           color: AppColors.whiteDarker,
            //         ),
            //       ),

            //       TextSpan(
            //         text: '      +2001004786215',
            //         style: TextStyles.cairoRegular16.copyWith(
            //           color: AppColors.whiteDarker,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 30.h),

            OtpTextfeild(
              oncompleted: (String val) {
                setState(() {
                  otpCode = val;
                  debugPrint(otpCode);
                });
              },
            ),

            SizedBox(height: 30.h),

            CustomElevatedButton(
              text: S.of(context).next,
              radius: CustomRadius.auth,
              withBorder: false,
              // width: 310,
              height: 48,
              fontStyle: TextStyles.bold16Tajawal,
              fun: () {
                if (otpCode.length == 4) {
                  context.read<VerifyOtpCubit>().verifyOtp(
                    widget.phoneNum,
                    otpCode,
                  );
                } else {
                  customSnackBar(
                    context: context,
                    msg: 'برجاء إدخال رمز صحيح',
                    isDone: false,
                  );
                }
              },
              suffixIconPath: 'assets/images/Arrow-right-2.svg',
            ),

            SizedBox(height: 20.h),

            CustomElevatedButton(
              text: S.of(context).resendCode,
              radius: CustomRadius.auth,
              backgColor: AppColors.blueLight,
              foregColor: AppColors.blueDarkActive,
              withBorder: false,
              // width: 310,
              height: 48,
              fontStyle: TextStyles.bold16Tajawal,
              fun: () {
                context.read<SendOtpCubit>().sendOtp(widget.phoneNum);
              },
            ),
          ],
        ),
      ),
    );
  }
}
