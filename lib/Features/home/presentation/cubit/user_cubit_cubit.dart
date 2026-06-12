import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
        debugPrint("Check Hive immediately: ${checkUser?.name}");
        emit(GetUserInfoSuccess(user: user));
        await getAndSendFCMToken();
      },
    );
  }

  Future<void> updateUserInfo({
    // required int id,
    required String name,
    required String email,
    File? image,
    bool removeImage = false,
  }) async {
    emit(UpdateUserInfoLoading());
    final result = await homeRepo.updateUserInfo(
      // id: id,
      name: name,
      email: email,
      image: image,
      removeImage: removeImage,
    );

    result.fold(
      (failure) => emit(UpdateUserInfoFailure(errMsg: failure.errorMsg)),
      (user) async {
        final box = Hive.box<UserDataModel>('user_box');
        await box.put('user', user);
        emit(UpdateUserInfoSuccess(user: user));
      },
    );
  }


  Future<void> getAndSendFCMToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? token = await messaging.getToken();

        if (token != null) {
          debugPrint("FCM Token Found: $token");

          final result = await homeRepo.sendDeviceToken(token: token);

          result.fold(
            (failure) => debugPrint(
              "Failed to sync token to backend: ${failure.errorMsg}",
            ),
            (_) {
              debugPrint("FCM Token synced successfully with backend!");
              _monitorTokenRefresh();
            },
          );
        }
      } else {
        debugPrint("User denied notification permissions");
      }
    } catch (e) {
      debugPrint("Error in getAndSendFCMToken: $e");
    }
  }

  void _monitorTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      debugPrint("FCM Token Refreshed: $newToken");
      await homeRepo.sendDeviceToken(token: newToken);
    });
  }

  // Future<void> loginWithToken(String token) async {
  //   await FirebaseAuthService().login(token);
  // }

  // Future<void> loginWithToken(String token) async {
  //   try {
  //     debugPrint('Sending token to Firebase...');

  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithCustomToken(token);

  //     debugPrint(
  //       'Firebase Auth Success! User UID: ${userCredential.user?.uid}',
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint('Firebase Auth Error Code: ${e.code}');
  //     debugPrint('Firebase Auth Error Message: ${e.message}');
  //   } catch (e) {
  //     debugPrint('General Auth Error: ${e.toString()}');
  //   }
  // }
}
