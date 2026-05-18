import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/auth/presentation/cubit/restore_password_cubit.dart';
import 'package:motoverse/Features/auth/presentation/views/bodies/restore_pass_body.dart';

// ignore: must_be_immutable
class RestorePass extends StatelessWidget {
  RestorePass({super.key});
  String fullPhoneNum = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestorePasswordCubit(getIt<AuthRepo>()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<RestorePasswordCubit, RestorePasswordState>(
          listener: (context, state) {
            if (state is RestorePasswordSuccess) {
              customSnackBar(
                context: context,
                msg: 'تم ارسال الكود بنجاح',
                isDone: true,
              );
              Navigator.of(
                context,
              ).pushNamed('otp forget', arguments: fullPhoneNum);
            }
            if (state is RestorePasswordFailure) {
              customSnackBar(context: context, msg: state.msg, isDone: true);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                color: AppColors.yellowNormal,
              ),
              inAsyncCall: state is RestorePasswordLoading, 
              child: RestorePassBody(
                getFullNum: (String phone) {
                  fullPhoneNum = phone;
                },
              ),
            );
          },
        )
        
        
      ),
    );
  }
}
