import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:motoverse/Features/auth/domain/entities/tokens_entity.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthRepo authrepo;
  LogInCubit(this.authrepo) : super(LogInInitial());

  Future<void> logIn({
    required String email,
    required String pass,
  })async{
    emit(LogInLoading());
    var response = await authrepo.logIn(email: email, pass: pass);

    response.fold(
      (failure){
        emit(LogInFailure(msg: failure.errorMsg));
      }, (success){
        emit(LogInSuccess(tokensEntity: success));
        // debugPrint(success.toString());
      });

  }
}
