import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/functions/custom_phonenum_feild.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/auth/presentation/cubit/send_otp_cubit.dart';
import 'package:motoverse/generated/l10n.dart';

class PhoneNumBody extends StatefulWidget {
  const PhoneNumBody({super.key, required this.getFullNum});
  final Function(String) getFullNum;

  @override
  State<PhoneNumBody> createState() => _PhoneNumBodyState();
}

class _PhoneNumBodyState extends State<PhoneNumBody> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedDialCode = "+20";

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SvgPicture.asset(
            'assets/images/logo1.svg',
            height: 50.h,
            width: 107.w,
          ),

          SizedBox(height: 20.h),

          Text(
            S.of(context).startJourney,
            style: TextStyles.cairoBold32.copyWith(color: AppColors.blueDarker),
          ),

          Text(
            S.of(context).addPhoneNumber,
            style: TextStyles.cairoRegular16.copyWith(
              color: AppColors.whiteDarker,
            ),
          ),

          Container(
            width: 305.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            margin: EdgeInsets.symmetric(vertical: 30.h),
            decoration: BoxDecoration(
              color: AppColors.whiteLight,
              borderRadius: BorderRadius.circular(35.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    S.of(context).phoneNumber,
                    style: TextStyles.cairoRegular16.copyWith(
                      color: AppColors.whiteNormalActive,
                    ),
                  ),
                ),

                SizedBox(height: 2.h),

                CustomPhonenumFeild(
                  controller: _phoneController,
                  onChanged: (code) {
                    _selectedDialCode = code;
                  },
                ),

                // IntlPhoneField(
                //   decoration: InputDecoration(
                //     counterText: '',
                //     border: InputBorder.none),
                //   initialCountryCode: 'EG',
                //   languageCode: 'ar',
                //   onChanged: (phone) {},
                //   onCountryChanged: (country) {},
                // ),
              ],
            ),
          ),

          SizedBox(height: 5.h),

          CustomElevatedButton(
            text: S.of(context).next,
            radius: CustomRadius.auth,
            withBorder: false,
            width: 310,
            height: 48,
            fontStyle: TextStyles.bold16Tajawal,
            fun: () {
              String fullPhoneNum = _selectedDialCode + _phoneController.text;
              widget.getFullNum(fullPhoneNum);
              // debugPrint(fullPhoneNum);
              if (_phoneController.text.isNotEmpty &&
                  _phoneController.text.length == 10) {
                context.read<SendOtpCubit>().sendOtp(fullPhoneNum);
              } else if (_phoneController.text.isEmpty) {
                customSnackBar(
                  context: context,
                  msg: 'برجاء إدخال رقم الهاتف',
                  isDone: false,
                );
              } else if (_phoneController.text.length != 10) {
                customSnackBar(
                  context: context,
                  msg: 'برجاء إدخال رقم هاتف صحيح',
                  isDone: false,
                );
              }
            },
            suffixIconPath: 'assets/images/Arrow-right-2.svg',
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.of(context).pushNamed('log in');
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'التالي',
          //         style: TextStyles.bold16Tajawal.copyWith(
          //           color: AppColors.whiteLight,
          //         ),
          //       ),
          //       SizedBox(width: 2.w),
          //       SvgPicture.asset('assets/images/Arrow-right-2.svg'),
          //     ],
          //   ),
          // ),
        ],
      ),
    ),
  );
}
}
