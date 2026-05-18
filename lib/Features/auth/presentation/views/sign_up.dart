import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/auth/presentation/cubit/complete_profile_cubit.dart';
import 'package:motoverse/Features/auth/presentation/views/bodies/sign_up_body.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(getIt<AuthRepo>()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
          listener: (context, state) {
            if (state is CompleteProfileSuccess) {
              customSnackBar(
                context: context,
                msg: state.response,
                isDone: true,
              );
              Navigator.of(context).pushNamed('log in');
            }
            if (state is CompleteProfileFailure) {
              customSnackBar(context: context, msg: state.msg, isDone: false);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                color: AppColors.yellowNormal,
              ),
              inAsyncCall: state is CompleteProfileLoading,
              child: SignUpBody(),
            );
          },
        ),
      ),
    );
  }
}
