import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/auth/presentation/cubit/send_otp_cubit.dart';
import 'package:motoverse/Features/auth/presentation/views/bodies/phone_num_body.dart';

// ignore: must_be_immutable
class PhoneNum extends StatelessWidget {
  PhoneNum({super.key});
  String fullPhoneNum = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendOtpCubit(getIt<AuthRepo>()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<SendOtpCubit, SendOtpState>(
          listener: (context, state) {
            if (state is SendOtpSuccess) {
              customSnackBar(
                context: context,
                msg: 'تم ارسال الكود بنجاح',
                isDone: true,
              );
              Navigator.of(
                context,
              ).pushNamed('otp page', arguments: fullPhoneNum);
            }
            if (state is SendOtpFailure) {
              customSnackBar(context: context, msg: state.msg, isDone: true);
            }
          },

          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                color: AppColors.yellowNormal,
              ),
              inAsyncCall: state is SendOtpLoading,
              child: PhoneNumBody(
                getFullNum: (phone) {
                  fullPhoneNum = phone;
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
