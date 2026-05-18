import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_textfeild.dart';
import 'package:motoverse/Features/auth/presentation/cubit/log_in_cubit.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:provider/provider.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({super.key});

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  bool securepass = true;

  Widget buildEyeIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          securepass = !securepass;
        });
      },
      icon: Icon(
        securepass ? Icons.visibility_off : Icons.visibility,
        color: AppColors.yellowNormal,
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
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
                S.of(context).welcomeTitle,
                style: TextStyles.cairoBold32.copyWith(
                  color: AppColors.blueDarker,
                ),
              ),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: S.of(context).welcomeSubtitle,
                      style: TextStyles.cairoRegular16.copyWith(
                        color: AppColors.whiteDarker,
                      ),
                    ),

                    TextSpan(
                      text: S.of(context).createNewAccount,
                      style: TextStyles.cairoRegular16.copyWith(
                        color: AppColors.blueNormal,
                      ),

                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed('phone number');
                        },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              CustomTextfeild(
                controller: email,
                hint: S.of(context).email,
                obsecure: false,
                keyboardType: TextInputType.emailAddress,
                hasBorder: false,
                radius: CustomRadius.auth,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء إدخال البريد الإلكتروني';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'برجاء إدخال بريد إلكتروني صحيح';
                  }
                  return null;
                },
              ),

              SizedBox(height: 12.h),

              CustomTextfeild(
                controller: password,
                hint: S.of(context).password,
                obsecure: securepass,
                keyboardType: TextInputType.visiblePassword,
                suffex: buildEyeIcon(),
                hasBorder: false,
                radius: CustomRadius.auth,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء إدخال كلمة المرور';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.h),

              CustomElevatedButton(
                text: S.of(context).login,
                radius: CustomRadius.auth,
                withBorder: false,
                width: 310,
                height: 48,
                fontStyle: TextStyles.cairoRegular16,
                fun: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LogInCubit>().logIn(
                      email: email.text,
                      pass: password.text,
                    );
                  }
                },
              ),

              SizedBox(height: 10.h),

              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('restore pass'),
                child: Text(
                  S.of(context).forgotPassword,
                  style: TextStyles.cairoRegular16.copyWith(
                    color: AppColors.yellowDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
