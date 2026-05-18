import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:motoverse/Core/services/firebase_auth_service.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';

part 'user_cubit_state.dart';

class UserCubitCubit extends Cubit<UserCubitState> {
  UserCubitCubit({required this.homeRepo, }) : super(UserCubitInitial());
  final HomeRepo homeRepo;

  Future<void> getUserToken() async {
    emit(GetUserTokenLoading());
    var result = await homeRepo.getUserToken();
    result.fold(
      (failure) => emit(GetUserTokenFailure(errMsg: failure.errorMsg)),
      (token) {
        debugPrint(token);
        loginWithToken(token);
        emit(GetUserTokenSuccess());
      },
    );
  }

  Future<void> getUserInfo() async {
    emit(GetUserInfoLoading());
    var result = await homeRepo.getUserInfo();
    result.fold(
      (failure) => emit(GetUserInfoFailure(errMsg: failure.errorMsg)),
      (user) async {
        var box = Hive.box<UserDataModel>('user_box');
        await box.put('user', user);
        emit(GetUserInfoSuccess(user: user));
      },
    );
  }

  Future<void> loginWithToken(String token) async {
    await FirebaseAuthService().login(token);
    
  }
}
