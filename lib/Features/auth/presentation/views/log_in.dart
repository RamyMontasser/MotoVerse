import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/services/secure_storage.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/auth/presentation/cubit/log_in_cubit.dart';
import 'package:motoverse/Features/auth/presentation/views/bodies/log_in_body.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {

    final secureStorage = getIt<SecureStorage>();

    return BlocProvider(
      create: (context) => LogInCubit(getIt<AuthRepo>()),
      child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<LogInCubit, LogInState>(
        listener: (context, state) async{
          if (state is LogInSuccess){
            
            secureStorage.saveAccessToken(
              access: state.tokensEntity.acccess,
            );
            secureStorage.saveRefreshToken(
              refresh: state.tokensEntity.refresh,
            );
            
            // String? storage = await secureStorage.getAccessExpiresTime();
            // debugPrint(storage);

            customSnackBar(context: context, msg: 'تم تسجيل الدخول', isDone: true);

            Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('main screen', (route) => false);
          }
          if (state is LogInFailure){
            customSnackBar(context: context, msg: state.msg, isDone: false);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LogInLoading,
            progressIndicator: CircularProgressIndicator(
              color: AppColors.yellowNormal,
            ),
            child: LogInBody());
        },
      )
    ),
    ); 
  } 
}
