class ServiceCenterModel {
  final int id;
  final String name;
  final String shortAddress;
  final double latitude;
  final double longitude;
  final String image;
  final List<ServiceModel> services;
  final String openingTime;
  final String closingTime;
  final double averageRating;
  final double distanceKm;
  final String phone;

  ServiceCenterModel({
    required this.id,
    required this.name,
    required this.shortAddress,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.services,
    required this.openingTime,
    required this.closingTime,
    required this.averageRating,
    required this.distanceKm,
    required this.phone,
  });

  factory ServiceCenterModel.fromJson(Map<String, dynamic> json) {
    return ServiceCenterModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      shortAddress: json['short_address'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? '',
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      openingTime: json['opening_time'] as String? ?? '',
      closingTime: json['closing_time'] as String? ?? '',
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0.0,
      phone: json['phone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_address': shortAddress,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
      'services': services.map((e) => e.toJson()).toList(),
      'opening_time': openingTime,
      'closing_time': closingTime,
      'average_rating': averageRating,
      'distance_km': distanceKm,
      'phone': phone,
    };
  }
}

class ServiceModel {
  final int id;
  final String name;
  final String duration;
  final String keyword;

  ServiceModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.keyword,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      keyword: json['keyword'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'keyword': keyword,
    };
  }
}
