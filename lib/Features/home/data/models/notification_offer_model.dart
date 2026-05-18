class OfferModel {
  final int id;
  final int request;
  final int helperId;
  final String helperName;
  final bool helperVerified;
  final String? helperImage;
  final String? distance;
  final String? estimatedMinutes;
  final String status;
  final String createdAt;

  OfferModel({
    required this.id,
    required this.request,
    required this.helperName,
     this.helperImage,
     this.distance,
     this.estimatedMinutes,
    required this.status,
    required this.createdAt, 
    required this.helperId,
    required this.helperVerified,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['offer_id'] as int? ?? 0,
      request: json['request_id'] as int? ?? 0,
      helperName: json['helper_name'] as String? ?? '',
      helperImage: json['helper_image'] as String?,
      distance: json['distance']?.toString(),
      estimatedMinutes: json['estimated_minutes']?.toString(),
      status: json['status'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      helperId: json['helper_id'] as int? ?? 0,
      helperVerified: json['helper_verified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offer_id': id,
      'request_id': request,
      'helper_id': helperId,
      'helper_name': helperName,
      'helper_verified': helperVerified,
      'helper_image': helperImage,
      'distance': distance,
      'estimated_minutes': estimatedMinutes,
      'status': status,
      'created_at': createdAt,
    };
  }
}
