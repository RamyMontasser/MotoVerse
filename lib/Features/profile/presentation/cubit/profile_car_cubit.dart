import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:motoverse/Features/profile/data/models/car_model.dart';
import 'package:motoverse/Features/profile/domain/repo/profile_car_repo.dart';

part 'profile_car_state.dart';

class ProfileCarCubit extends Cubit<ProfileCarState> {
  final ProfileCarRepo profileCarRepo;

  ProfileCarCubit({required this.profileCarRepo}) : super(ProfileCarInitial());

  Future<void> fetchCars() async {
    emit(ProfileCarLoading());
    final result = await profileCarRepo.getCars();
    result.fold(
      (failure) => emit(ProfileCarFailure(errorMsg: failure.errorMsg)),
      (cars) => emit(ProfileCarSuccess(cars: cars)),
    );
  }

  Future<void> addCar(CarModel car) async {
    emit(AddOrUpdateCarLoading());
    final result = await profileCarRepo.addCar(car);
    result.fold(
      (failure) => emit(AddOrUpdateCarFailure(errorMsg: failure.errorMsg)),
      (_) {
        emit(AddOrUpdateCarSuccess());
        fetchCars();
      },
    );
  }

  Future<void> updateCar(int id, CarModel car) async {
    emit(AddOrUpdateCarLoading());
    final result = await profileCarRepo.updateCar(id, car);
    result.fold(
      (failure) => emit(AddOrUpdateCarFailure(errorMsg: failure.errorMsg)),
      (_) {
        emit(AddOrUpdateCarSuccess());
        fetchCars();
      },
    );
  }

  Future<void> deleteCar(int id) async {
    emit(AddOrUpdateCarLoading());
    final result = await profileCarRepo.deleteCar(id);
    result.fold(
      (failure) => emit(AddOrUpdateCarFailure(errorMsg: failure.errorMsg)),
      (_) {
        emit(AddOrUpdateCarSuccess());
        fetchCars();
      },
    );
  }
}
