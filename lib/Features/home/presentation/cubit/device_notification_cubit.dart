import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/home/data/models/notificaion_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';

part 'device_notification_state.dart';

class DeviceNotificationCubit extends Cubit<DeviceNotificationState> {
  final HomeRepo homeRepo;
   List<NotificationModel> _cachedNotifications = [];
  DeviceNotificationCubit({required this.homeRepo}) : super(DeviceNotificationInitial());

 
  Future<void> fetchNotifications({bool isRefresh = false}) async {
    if (!isRefresh && _cachedNotifications.isNotEmpty) {
      emit(DeviceNotificationSuccess(_cachedNotifications));
      return;
    }

    emit(DeviceNotificationLoading());

    final result = await homeRepo.getNotifications();

    result.fold(
      (failure) {
        if (_cachedNotifications.isNotEmpty) {
          emit(DeviceNotificationSuccess(_cachedNotifications));
        } else {
          emit(DeviceNotificationError(failure));
        }
      },
      (notifications) {
        debugPrint('latest notification: ${notifications.firstOrNull?.createdAt}');

        _cachedNotifications = notifications;
        emit(DeviceNotificationSuccess(notifications));
      },
    );
  }
}
