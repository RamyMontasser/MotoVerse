import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/functions/custom_phonenum_feild.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/auth/presentation/cubit/restore_password_cubit.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:provider/provider.dart';

class RestorePassBody extends StatefulWidget {
  const RestorePassBody({super.key, required this.getFullNum});
  final Function(String) getFullNum;

  @override
  State<RestorePassBody> createState() => _RestorePassBodyState();
}

class _RestorePassBodyState extends State<RestorePassBody> {
  final _formKey = GlobalKey<FormState>();

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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logo1.svg',
                height: 60.h,
                width: 110.w,
              ),

              SizedBox(height: 20.h),

              Text(
                S.of(context).restorePassword,
                style: TextStyles.cairoBold32.copyWith(
                  color: AppColors.blueDarker,
                ),
              ),

              Text(
                S.of(context).restorePasswordSubtitle,
                style: TextStyles.cairoRegular16.copyWith(
                  color: AppColors.whiteDarker,
                ),
              ),

              SizedBox(height: 30.h),

              // CustomTextfeild(
              //   controller: phoneNumber,
              //   hint: S.of(context).phoneNumber,
              //   obsecure: false,
              //   keyboardType: TextInputType.phone,
              //   hasBorder: false,
              //   radius: CustomRadius.auth,
              // ),
              Container(
                width: 305.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                margin: EdgeInsets.symmetric(vertical: 30.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteLight,
                  borderRadius: BorderRadius.circular(35.r),
                ),
                child:
                    // Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // children: [
                    //   Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 10.h),
                    //     child: Text(
                    //       S.of(context).phoneNumber,
                    //       style: TextStyles.cairoRegular16.copyWith(
                    //         color: AppColors.whiteNormalActive,
                    //       ),
                    //     ),
                    //   ),
                    // SizedBox(height: 2.h),
                    CustomPhonenumFeild(
                      controller: _phoneController,
                      onChanged: (code) {
                        _selectedDialCode = code;
                      },
                    ),
                // ],
                // ),
              ),
              SizedBox(height: 20.h),

              CustomElevatedButton(
                text: S.of(context).restorePassword,
                radius: CustomRadius.auth,
                withBorder: false,
                width: 310,
                height: 48,
                fontStyle: TextStyles.cairoRegular16,
                fun: () {
                  String fullPhoneNum =
                      _selectedDialCode + _phoneController.text;
                  widget.getFullNum(fullPhoneNum);
                  // debugPrint(fullPhoneNum);
                  if (_phoneController.text.isNotEmpty &&
                      _phoneController.text.length == 10) {
                    context.read<RestorePasswordCubit>().request(
                      phoneNum: fullPhoneNum,
                    );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
