import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
// import 'package:motoverse/Core/services/firebase_auth_service.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';

part 'user_cubit_state.dart';

class UserCubitCubit extends Cubit<UserCubitState> {
  UserCubitCubit({required this.homeRepo}) : super(UserCubitInitial());
  final HomeRepo homeRepo;

  void reset() {
    emit(UserCubitInitial());
  }

  // Future<void> getUserToken() async {
  //   emit(GetUserTokenLoading());
  //   final result = await homeRepo.getUserToken();
  //   await result.fold(
  //     (failure) async=> emit(GetUserTokenFailure(errMsg: failure.errorMsg)),
  //     (token) async {
  //       debugPrint(token);
  //       // debugPrint('📏 Token Length: ${token.length}');
  //       // debugPrint('🔍 Clean Token: ${token.trim()}');
  //       // await loginWithToken(token);
  //       emit(GetUserTokenSuccess());
  //     },
  //   );
  // }

  Future<void> getUserInfo() async {
    emit(GetUserInfoLoading());
    var result = await homeRepo.getUserInfo();
    result.fold(
      (failure) {
        debugPrint("user name from cubit is ${failure.errorMsg}");
        emit(GetUserInfoFailure(errMsg: failure.errorMsg));
      },
      (user) async {
        debugPrint("user name from cubit is ${user.name}");

        var box = Hive.box<UserDataModel>('user_box');
        await box.put('user', user);
        var checkUser = box.get('user');
        debugPrint("🔍 Check Hive immediately: ${checkUser?.name}");
        emit(GetUserInfoSuccess(user: user));
      },
    );
  }

  // Future<void> loginWithToken(String token) async {
  //   await FirebaseAuthService().login(token);
  // }

  // Future<void> loginWithToken(String token) async {
  //   try {
  //     debugPrint('🚀 Sending token to Firebase...');

  //     // هنسجل دخول هنا مباشرة عشان نقطع الشك باليقين ونشوف رد الفايربيس
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithCustomToken(token);

  //     debugPrint(
  //       '✅ Firebase Auth Success! User UID: ${userCredential.user?.uid}',
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     // هنا الفايربيس لو رفض التوكن هيقولنا السبب الصريح (مثلاً: invalid-custom-token)
  //     debugPrint('❌ Firebase Auth Error Code: ${e.code}');
  //     debugPrint('❌ Firebase Auth Error Message: ${e.message}');
  //   } catch (e) {
  //     debugPrint('❌ General Auth Error: ${e.toString()}');
  //   }
  // }
}
