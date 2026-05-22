import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';

// import 'package:motoverse/Features/socket_chat/services/socket_service.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepo authRepo;
  // final SocketService socketService;

  LogoutCubit(
    this.authRepo,
    //  this.socketService
  ) : super(LogoutInitial());

  Future<void> logout(BuildContext? context) async {
    emit(LogoutLoading());
    final userBox = Hive.box<UserDataModel>('user_box');

    try {
      var response = await authRepo.logOut();
      response.fold(
        (failure) {
          debugPrint("Logout Failure: ${failure.errorMsg}");
          emit(LogoutFailure(msg: failure.errorMsg));
        },
        (success) {
          debugPrint("Logout Success");
          emit(LogoutSuccess());
        },
      );
    } finally {
      // Disconnect socket service
      // socketService.disconnect();

      // Clear cached user data from Hive
      if (userBox.isOpen) {
        await userBox.delete('user');
      }

      // Reset cubits if context is available
      if (context != null) {
        try {
          context.read<CurrentLocationCubit>().reset();
          context.read<UserCubitCubit>().reset();
        } catch (e) {
          debugPrint("Error resetting cubits: $e");
        }
      }
    }
  }
}
