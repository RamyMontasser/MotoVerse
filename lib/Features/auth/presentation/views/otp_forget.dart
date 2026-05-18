import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/auth/presentation/cubit/verify_reset_pass_cubit.dart';
import 'package:motoverse/Features/auth/presentation/views/bodies/otp_forget_body.dart';
import 'package:motoverse/Features/auth/presentation/cubit/send_otp_cubit.dart';

class OtpForget extends StatelessWidget {
  const OtpForget({super.key});

  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)!.settings.arguments as String;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VerifyResetPassCubit(getIt<AuthRepo>())),
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
            BlocListener<VerifyResetPassCubit, VerifyResetPassState>(
              listener: (context, state) {
                if (state is VerifyResetPassSuccess) {
                  customSnackBar(
                    context: context,
                    msg: 'تم تأكيد رقم الهاتف',
                    isDone: true,
                  );
                  String resetToken = state.resetToken;
                  debugPrint(resetToken);
                  Navigator.of(
                    context,
                  ).pushNamed('reset pass', arguments: resetToken);
                }
                if (state is VerifyResetPassFailure) {
                  customSnackBar(context: context, msg: state.msg, isDone: false);
                }
              },
            ),
          ],
          child: BlocBuilder<VerifyResetPassCubit, VerifyResetPassState>(
            builder: (context, verifyState) {
              return BlocBuilder<SendOtpCubit, SendOtpState>(
                builder: (context, sendState) {
                  return ModalProgressHUD(
                    progressIndicator: CircularProgressIndicator(
                      color: AppColors.yellowNormal,
                    ),
                    inAsyncCall: verifyState is VerifyResetPassLoading ||
                        sendState is SendOtpLoading,
                    child: OtpForgetBody(phone: phone),
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
