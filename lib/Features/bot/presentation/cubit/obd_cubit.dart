import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:meta/meta.dart';
import 'package:motoverse/Features/bot/data/models/obd_metrics.dart';
import 'package:motoverse/Features/bot/domain/repo/obd_repo.dart';

part 'obd_state.dart';

class ObdCubit extends Cubit<ObdState> {
  final ObdRepo _obdRepo;
  StreamSubscription<Map<String, dynamic>>? _simulationSubscription;

  final List<FlSpot> _rpmSpots = [];
  final List<FlSpot> _speedSpots = [];
  int _chartXCoordinate = 0;

  ObdCubit(this._obdRepo) : super(ObdInitial());

  // double _parseSafeDouble(dynamic value) {
  //   if (value == null) return 0.0;
  //   if (value is num) return value.toDouble(); 

  //   final cleanString = value.toString().replaceAll(RegExp(r'[^0-9.]'), '');
  //   return double.tryParse(cleanString) ?? 0.0;
  // }

  void startSimulation(PlatformFile file) async {
    emit(ObdLoading());

    try {
      await _simulationSubscription?.cancel();

      _rpmSpots.clear();
      _speedSpots.clear();
      _chartXCoordinate = 0;

      _simulationSubscription = _obdRepo
          .startObdSimulation(file)
          .listen(
            (currentRow) {
              String safeStr(dynamic value, String fallback) {
                if (value == null ||
                    value.toString().trim().isEmpty ||
                    value.toString().trim().toLowerCase() == 'null') {
                  return fallback;
                }
                return value.toString().trim();
              }
              final carModelRaw =
                  currentRow['carModel']?.toString() ?? 'Unknown Car';
                
              final faultRaw = currentRow['faultCode']?.toString() ?? '';
              final String? finalFaultCode =
                  (faultRaw.isEmpty || faultRaw.toLowerCase() == 'null')
                  ? null
                  : faultRaw;

              final rpmRaw = safeStr(currentRow['rpm'], '0');
              final speedRaw = safeStr(currentRow['speed'], '0');
              final tempRaw = safeStr(currentRow['temp'], '0');
              final fuelRaw = safeStr(currentRow['fuel'], '0');
              final loadRaw = safeStr(currentRow['load'], '0');
              final intakeRaw = safeStr(currentRow['intake'], '0');
              final baroRaw = safeStr(currentRow['baro'], '0');
              final runtimeRaw = safeStr(currentRow['runtime'], '0');

              final fuelDouble = double.tryParse(fuelRaw) ?? 0.0;
              final loadDouble = double.tryParse(loadRaw) ?? 0.0;
              final tempDouble = double.tryParse(tempRaw) ?? 0.0;
              final rpmForChart = double.tryParse(rpmRaw) ?? 0.0;
              final speedForChart = double.tryParse(speedRaw) ?? 0.0;

              final fuelProgress = fuelDouble / 100.0;
              final loadProgress = loadDouble / 100.0;
              final tempProgress = (tempDouble / 150.0).clamp(0.0, 1.0);

              _rpmSpots.add(
                FlSpot(_chartXCoordinate.toDouble(), rpmForChart),
              ); 
              _speedSpots.add(
                FlSpot(_chartXCoordinate.toDouble(), speedForChart),
              );

              if (_rpmSpots.length > 15) _rpmSpots.removeAt(0);
              if (_speedSpots.length > 15) _speedSpots.removeAt(0);

              _chartXCoordinate++;

              final metrics = ObdMetrics(
                faultCode: finalFaultCode,
                carModel: carModelRaw,
                fuelLevel: '$fuelRaw%',
                fuelProgress: fuelProgress,
                engineTemp: '$tempRaw°C',
                tempProgress: tempProgress,
                engineLoad: '$loadRaw%',
                loadProgress: loadProgress,
                rpmValue: rpmRaw,
                speedValue: speedRaw,
                intakeAirTemp: '$intakeRaw°C',
                barometricPressure: '$baroRaw kPa',
                runtimeValue: runtimeRaw,
                rpmSpots: List.from(_rpmSpots),
                speedSpots: List.from(_speedSpots),
              );

              emit(ObdDataUpdated(metrics));
            },
            onDone: () => emit(ObdFinished()),
            onError: (error) => emit(ObdError("خطأ: $error")),
          );
    } catch (e) {
      emit(ObdError("فشل في بدء المحاكاة: $e"));
    }
  }

  @override
  Future<void> close() {
    _simulationSubscription?.cancel();
    return super.close();
  }
}
