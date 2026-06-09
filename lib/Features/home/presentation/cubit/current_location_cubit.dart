import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';
import 'package:motoverse/Features/home/domain/repo/map_repo.dart';

part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  final MapRepo mapRepo;
  final HomeRepo homeRepo;
  CurrentLocationCubit(this.mapRepo, this.homeRepo)
    : super(CurrentLocationInitial());

  // final MapController mapController = MapController();
  Position? lastKnownPosition;
  // bool _isProfileUpdated = false;

  // @override
  // Future<void> close() {
  //   mapController.dispose();
  //   return super.close();
  //    }

  void reset() {
    lastKnownPosition = null;
    emit(CurrentLocationInitial());
  }

  Future<void> getCurrentLocation({bool forceRefresh = false}) async {
    if (!forceRefresh && lastKnownPosition != null) return;
    emit(CurrentLocationLoading());
    var response = await mapRepo.getCurrentLocation();
    response.fold(
      (fail) {
        emit(CurrentLocationFailure(errMsg: fail.errorMsg));
      },
      (location) async {
        debugPrint(
          'Current Location: ${location.latitude}, ${location.longitude}',
        );
        lastKnownPosition = location;

        var cityResponse = await mapRepo.getCurrentCity(position: location);
        String? cityName;
        cityResponse.fold((l) => null, (city) => cityName = city);

        var countResponse = await mapRepo.getNearestCentersCount(
          latitude: location.latitude,
          longitude: location.longitude,
        );

        int centersCount = 0;
        countResponse.fold(
          (fail) => debugPrint(
            '❌ Failed to get nearest centers count: ${fail.errorMsg}',
          ),
          (count) => centersCount = count,
        );

        emit(
          CurrentLocationSuccess(
            currentLocation: location,
            cityName: cityName,
            nearestCentersCount: centersCount,
          ),
        );

        if (cityName != null) {
          await homeRepo.updateProfile(city: cityName!);
          debugPrint('Current city updated to : $cityName');
        }
      },
    );
  }

  void zoomIn({required MapController mapController}) {
    double currentZoom = mapController.camera.zoom;
    mapController.move(mapController.camera.center, currentZoom + 1);
  }

  void zoomOut({required MapController mapController}) {
    double currentZoom = mapController.camera.zoom;
    mapController.move(mapController.camera.center, currentZoom - 1);
  }

  void moveToCurrentPosition(
    double lat,
    double lng, {
    required MapController mapController,
  }) {
    mapController.move(LatLng(lat, lng), 16.0);
  }

  // void moveToCurrentPosition(double lat, double lng) {
  //   mapController.moveAnimated(
  //     LatLng(lat, lng),
  //     17.0,
  //     duration: const Duration(milliseconds: 800),
  //   );
  // }
}
