import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/auth/presentation/cubit/verify_otp_cubit.dart';
import 'package:motoverse/Features/auth/presentation/views/bodies/otp_page_body.dart';
import 'package:motoverse/Features/auth/presentation/cubit/send_otp_cubit.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  // late final SmsRetriever smsRetriever;
  @override
  Widget build(BuildContext context) {
    final String fullPhoneNum =
        ModalRoute.of(context)!.settings.arguments as String;

    // final tokenService = getIt<TokenService>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VerifyOtpCubit(getIt<AuthRepo>())),
        BlocProvider(create: (context) => SendOtpCubit(getIt<AuthRepo>())),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: MultiBlocListener(
          listeners: [
            BlocListener<SendOtpCubit, SendOtpState>(
              listener: (context, state) {
                if (state is SendOtpSuccess) {
                  customSnackBar(
                    context: context,
                    msg: 'تم إعادة إرسال الكود بنجاح',
                    isDone: true,
                  );
                }
                if (state is SendOtpFailure) {
                  customSnackBar(context: context, msg: state.msg, isDone: false);
                }
              },
            ),
            BlocListener<VerifyOtpCubit, VerifyOtpState>(
              listener: (context, state) {
                if (state is VerifyOtpSuccess) {
                  customSnackBar(
                    context: context,
                    msg: 'تم تأكيد رقم الهاتف',
                    isDone: true,
                  );
                  String verifyToken = state.phoneEntity.verificationToken;
                  debugPrint('Token from Cubit: $verifyToken');
                  // await tokenService.saveVerifyToken(verifyToken: verifyToken);
                  Navigator.of(
                    context,
                  ).pushNamed('sign up', arguments: verifyToken);
                }

                if (state is VerifyOtpFailure) {
                  customSnackBar(context: context, msg: state.msg, isDone: false);
                }
              },
            ),
          ],
          child: BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
            builder: (context, verifyState) {
              return BlocBuilder<SendOtpCubit, SendOtpState>(
                builder: (context, sendState) {
                  return ModalProgressHUD(
                    progressIndicator: CircularProgressIndicator(
                      color: AppColors.yellowNormal,
                    ),
                    inAsyncCall: verifyState is VerifyOtpLoading ||
                        sendState is SendOtpLoading,
                    child: OtpPageBody(phoneNum: fullPhoneNum),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
