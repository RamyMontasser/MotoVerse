import 'package:motoverse/Features/community/data/models/request_image_model.dart';
import 'package:motoverse/Features/community/data/models/request_location_model.dart';
import 'package:motoverse/Features/community/domain/entities/request_entity.dart';

class RequestModel {
  final int id;
  final int userId;
  final String userName;
  final String? userImage;
  final int memberSince;
  final String city;
  final String averageRating;
  final RequestLocationModel? location;
  final double? distance;
  final String description;
  final String problemType;
  final String requestType;
  final List<RequestImageModel> images;
  final int imagesCount;
  final String status;
  final String createdAt;

  RequestModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.memberSince,
    required this.city,
    this.location,
    this.distance,
    required this.description,
    required this.problemType,
    required this.requestType,
    required this.images,
    required this.imagesCount,
    required this.status,
    required this.createdAt,
    required this.averageRating,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['request_id'] as int? ?? 0,
      userId: json['user_id'] as int? ?? 0,
      userName: json['user']?.toString() ?? '',
      userImage: json['user_image']?.toString(),
      memberSince: json['member_since'] as int? ?? 0,
      city: json['city']?.toString() ?? '',
      averageRating: json['average_rating'] == null
          ? ''
          : (json['average_rating'] is num
                ? (json['average_rating'] as num).toString()
                : json['average_rating'].toString()),
      location: RequestLocationModel.fromJson(json['location'] ?? {}),
      distance: (json['distance'] as num?)?.toDouble(),
      description: json['description']?.toString() ?? '',
      problemType: json['problem_type']?.toString() ?? '',
      requestType: json['request_type']?.toString() ?? '',
      images:
          (json['images'] as List<dynamic>?)
              ?.map(
                (e) => RequestImageModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      imagesCount: json['images_count'] as int? ?? 0,
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': id,
      'user_id': userId,
      'user': userName,
      'user_image': userImage,
      'member_since': memberSince,
      'city': city,
      'average_rating': averageRating,
      'location': location?.toJson(),
      'distance': distance,
      'description': description,
      'problem_type': problemType,
      'request_type': requestType,
      'images': images.map((e) => e.toJson()).toList(),
      'images_count': imagesCount,
      'status': status,
      'created_at': createdAt,
    };
  }

  RequestEntity toEntity() {
    return RequestEntity(
      id: id,
      userId: userId,
      userName: userName,
      userImage: userImage,
      memberSince: memberSince,
      description: description,
      problemType: problemType,
      requestType: requestType,
      images: images,
      imagesCount: imagesCount,
      status: status,
      createdAt: createdAt,
      averageRating: averageRating,
      city: requestType == 'offline' ? city : null,
      location: requestType == 'offline' ? location : null,
      distance: requestType == 'offline' ? distance : null,
    );
  }

  factory RequestModel.fromEntity(RequestEntity entity) {
    return RequestModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      userImage: entity.userImage,
      memberSince: entity.memberSince,
      city: entity.city ?? '',
      location: entity.location,
      distance: entity.distance,
      description: entity.description,
      problemType: entity.problemType,
      requestType: entity.requestType,
      images: entity.images,
      imagesCount: entity.imagesCount,
      status: entity.status,
      createdAt: entity.createdAt,
      averageRating: entity.averageRating,
    );
  }
}
