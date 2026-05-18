import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_textfeild.dart';
import 'package:motoverse/Features/auth/presentation/cubit/confirm_reset_pass_cubit.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:provider/provider.dart';

class ResetPassBody extends StatefulWidget {
  const ResetPassBody({super.key, required this.resetToken});
  final String resetToken;

  @override
  State<ResetPassBody> createState() => _ResetPassBodyState();
}

class _ResetPassBodyState extends State<ResetPassBody> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();

  TextEditingController passwordConf = TextEditingController();

  SvgPicture showenPass = SvgPicture.asset(
    'assets/images/visability_linear.svg',
    color: AppColors.blueDarker,
  );

  SvgPicture hidenPass = SvgPicture.asset(
    'assets/images/visability_bold.svg',
    color: AppColors.blueDarker,
  );

  bool securepass = true;

  Widget buildEyeIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          securepass = !securepass;
        });
      },
      icon: securepass ? hidenPass : showenPass,
    );
  }

  @override
  void dispose() {
    password.dispose();
    passwordConf.dispose();
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
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logo1.svg',
                height: 60.h,
                width: 110.w,
              ),

              SizedBox(height: 20.h),

              Text(
                S.of(context).resetPasswordTitle,
                style: TextStyles.cairoBold32.copyWith(
                  color: AppColors.blueDarker,
                ),
              ),

              Text(
                S.of(context).createPasswordTitle,
                style: TextStyles.cairoRegular16.copyWith(
                  color: AppColors.whiteDarker,
                ),
              ),

              SizedBox(height: 30.h),

              CustomTextfeild(
                controller: password,
                hint: S.of(context).newPassword,
                obsecure: securepass,
                keyboardType: TextInputType.visiblePassword,
                suffex: buildEyeIcon(),
                hasBorder: false,
                radius: CustomRadius.auth,
              ),

              SizedBox(height: 12.h),

              CustomTextfeild(
                controller: passwordConf,
                hint: S.of(context).confirmPassword,
                obsecure: securepass,
                keyboardType: TextInputType.visiblePassword,
                suffex: buildEyeIcon(),
                hasBorder: false,
                radius: CustomRadius.auth,
              ),

              SizedBox(height: 20.h),

              CustomElevatedButton(
                text: S.of(context).update,
                radius: CustomRadius.auth,
                withBorder: false,
                width: 310,
                height: 48,
                fontStyle: TextStyles.cairoRegular16,
                fun: () {
                  if (password.text == passwordConf.text) {
                    context.read<ConfirmResetPassCubit>().confirm(
                      resetToken: widget.resetToken,
                      password: password.text,
                    );
                  } else {
                    customSnackBar(
                      context: context,
                      msg: 'الخانتان غير متماثلتان',
                      isDone: false,
                    );
                  }
                },
              ),

              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
