import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/auth/presentation/cubit/confirm_reset_pass_cubit.dart';
import 'package:motoverse/Features/auth/presentation/views/bodies/reset_pass_body.dart';

class ResetPass extends StatelessWidget {
  const ResetPass({super.key});

  @override
  Widget build(BuildContext context) {
    final String resetToken = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => ConfirmResetPassCubit(getIt<AuthRepo>()),
      child: Scaffold(
        resizeToAvoidBottomInset: true, 
        body: BlocConsumer<ConfirmResetPassCubit, ConfirmResetPassState>(
          listener: (context, state) {
            if (state is ConfirmResetPassSuccess){
              customSnackBar(context: context, msg: 'تم تغيير كلمة المرور بنجاح', isDone: true);
              Navigator.of(context).pushNamed('log in');
            }
            if (state is ConfirmResetPassFailure){
              customSnackBar(context: context, msg: state.msg, isDone: false);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                color: AppColors.yellowNormal,
              ),
              inAsyncCall: state is ConfirmResetPassLoading, 
              child: ResetPassBody(resetToken: resetToken,),
            );
          },
        )
        ),
    );
  }
}
