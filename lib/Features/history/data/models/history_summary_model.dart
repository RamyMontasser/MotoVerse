import 'package:motoverse/Features/history/data/models/car_history_model.dart';

class HistorySummaryModel {
  final CarHistoryModel? lastMaintenance;
  final num totalCost;

  HistorySummaryModel({
    required this.lastMaintenance,
    required this.totalCost,
  });

  factory HistorySummaryModel.fromJson(Map<String, dynamic> json) {
    return HistorySummaryModel(
      lastMaintenance: json['last_maintenance'] != null
          ? CarHistoryModel.fromJson(json['last_maintenance'])
          : null,
      totalCost: json['total_cost'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_maintenance': lastMaintenance?.toJson(),
      'total_cost': totalCost,
    };
  }
}
