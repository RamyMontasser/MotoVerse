class AiAnalysisModel {
  final String carModel;
  final String status;
  final int anomalies;
  final double anomalyRatio;

  AiAnalysisModel({
    required this.carModel,
    required this.status,
    required this.anomalies,
    required this.anomalyRatio,
  });

  factory AiAnalysisModel.fromJson(Map<String, dynamic> json) {
    return AiAnalysisModel(
      carModel: json['car_model']?.toString() ?? 'Unknown',
      status: json['status']?.toString() ?? 'Unknown',
      anomalies: (json['anomalies'] as num?)?.toInt() ?? 0,
      anomalyRatio: (json['anomaly_ratio'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() =>
      'AiAnalysisModel(carModel: $carModel, status: $status, anomalies: $anomalies, anomalyRatio: $anomalyRatio)';
}
