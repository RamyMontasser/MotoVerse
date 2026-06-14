import 'package:fl_chart/fl_chart.dart';

class ObdMetrics {
  final String fuelLevel;
  final double fuelProgress;
  final String engineTemp;
  final double tempProgress;
  final String engineLoad;
  final double loadProgress;
  final String rpmValue;
  final String speedValue;
  final String intakeAirTemp;
  final String barometricPressure;
  final String runtimeValue;
  final List<FlSpot> rpmSpots;
  final List<FlSpot> speedSpots;
  final String carModel;
  final String? faultCode;
  // no AI fields here — keep this model focused on OBD metrics

  // final String? column1;
  // final String? column2;
  // final String? column3;

  ObdMetrics({
    required this.fuelLevel,
    required this.fuelProgress,
    required this.engineTemp,
    required this.tempProgress,
    required this.engineLoad,
    required this.loadProgress,
    required this.rpmValue,
    required this.speedValue,
    required this.intakeAirTemp,
    required this.barometricPressure,
    required this.runtimeValue,
    required this.rpmSpots,
    required this.speedSpots,
    required this.carModel,
    this.faultCode,
    //  this.column1, this.column2, this.column3,
  });

  // String get carFullModel {
  //   final brand = column1 ?? '';
  //   final model = column2 ?? '';
  //   final year = column3 ?? '';
  //   final fullName = '$brand $model $year'.trim().replaceAll(
  //     RegExp(r'\s+'),
  //     ' ',
  //   );
  //   return fullName.isNotEmpty
  //       ? fullName
  //       : 'Toyota Corolla 2020'; // نص احتياطي افتراضي
  // }
}
