class RequestLocationModel {
  final double latitude;
  final double longitude;

  RequestLocationModel({required this.latitude, required this.longitude});

  factory RequestLocationModel.fromJson(Map<String, dynamic> json) {
    return RequestLocationModel(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}
