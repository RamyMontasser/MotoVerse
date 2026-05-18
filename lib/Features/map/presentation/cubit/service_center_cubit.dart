import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motoverse/Features/map/data/models/service_center_model.dart';
import 'package:motoverse/Features/map/domain/repo/service_center_repo.dart';

part 'service_center_state.dart';

class ServiceCenterCubit extends Cubit<ServiceCenterState> {
  final ServiceCenterRepo serviceCenterRepo;
  ServiceCenterCubit({required this.serviceCenterRepo})
    : super(ServiceCenterInitial());

  List<ServiceCenterModel> cachedCenters = [];

  Future<void> fetchServiceCenters({
    required double lat,
    required double long,
  }) async {
    emit(ServiceCenterLoading());
    final result = await serviceCenterRepo.getServiceCenters(
      lat: lat,
      long: long,
    );
    result.fold(
      (failure) => emit(ServiceCenterFail(errorMessage: failure.errorMsg)),
      (centers) {
        cachedCenters = centers;
        emit(ServiceCenterSuccess(serviceCenters: centers));
      },
    );
  }

  void fetchServiceCenterDetails(int id) {
    emit(ServiceCenterDetailsLoading());
    try {
      final center = cachedCenters.firstWhere((center) => center.id == id);
      emit(ServiceCenterDetailsSuccess(serviceCenter: center));
    } catch (e) {
      emit(ServiceCenterDetailsFail(errorMessage: 'Service center not found'));
    }
  }

  void emitServiceCenters() {
    if (cachedCenters.isNotEmpty) {
      emit(ServiceCenterSuccess(serviceCenters: cachedCenters));
    }
  }

  void searchServiceCenters(String query) {
    if (query.isEmpty) {
      emitServiceCenters();
    } else {
      final filteredCenters = cachedCenters.where((center) {
        return center.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(ServiceCenterSuccess(serviceCenters: filteredCenters));
    }
  }
}
