import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_textfeild.dart';
import 'package:motoverse/Features/auth/domain/entities/user_entity.dart';
import 'package:motoverse/Features/auth/presentation/cubit/complete_profile_cubit.dart';
import 'package:motoverse/Features/auth/presentation/views/widgets/rules.dart';
import 'package:motoverse/generated/l10n.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  bool securepass = true;
  bool isTermsAccepted = false;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  // final tokenService = getIt<TokenService>();
  // String? verfyToken;

  // @override
  // void initState() {
  //   _fetchToken();
  //   super.initState();
  // }

  // Future<void> _fetchToken() async {
  //   final token = await tokenService.getVerifyToken();
  //   setState(() {
  //     verfyToken = token;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final String verifyToken =
        ModalRoute.of(context)!.settings.arguments as String;
    debugPrint('Token in SignUp: $verifyToken');
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
                S.of(context).createNewAccount,
                style: TextStyles.cairoBold32.copyWith(
                  color: AppColors.blueDarker,
                ),
              ),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: S.of(context).alreadyHaveAccount,
                      style: TextStyles.cairoRegular16.copyWith(
                        color: AppColors.whiteDarker,
                      ),
                    ),

                    TextSpan(
                      text: S.of(context).login,
                      style: TextStyles.cairoRegular16.copyWith(
                        color: AppColors.blueNormal,
                      ),

                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed('log in');
                        },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              CustomTextfeild(
                controller: name,
                hint: S.of(context).fullName,
                obsecure: false,
                keyboardType: TextInputType.name,
                hasBorder: false,
                radius: CustomRadius.auth,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء إدخال الاسم بالكامل';
                  }
                  return null;
                },
              ),

              SizedBox(height: 12.h),

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
                  if (value.length < 8) {
                    return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
                  }
                  return null;
                },
              ),

              SizedBox(height: 10.h),

              Roles(
                value: isTermsAccepted,
                onChanged: (val) {
                  setState(() {
                    isTermsAccepted = val ?? false;
                  });
                },
              ),

              SizedBox(height: 20.h),

              CustomElevatedButton(
                text: S.of(context).createAccount,
                radius: CustomRadius.auth,
                withBorder: false,
                width: 310,
                height: 48,
                fontStyle: TextStyles.cairoRegular16,
                fun: () {
                  if (_formKey.currentState!.validate()) {
                    if (isTermsAccepted) {
                      context.read<CompleteProfileCubit>().complete(
                        userEntity: UserEntity(
                          name: name.text,
                          email: email.text,
                          password: password.text,
                        ),
                        verifyToken: verifyToken,
                      );
                      debugPrint(verifyToken);
                    } else {
                      customSnackBar(
                        context: context,
                        msg: 'برجاء الموافقة على الشروط والأحكام',
                        isDone: false,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}
