import 'package:motoverse/Features/community/data/models/request_image_model.dart';
import 'package:motoverse/Features/community/data/models/request_location_model.dart';

class RequestEntity {
  final int id;
  final int userId;
  final String userName;
  final String? userImage;
  final int memberSince;
  final String description;
  final String problemType;
  final String requestType;
  final List<RequestImageModel> images;
  final int imagesCount;
  final String status;
  final String createdAt;

  final String? city;
  final RequestLocationModel? location;
  final double? distance;

  RequestEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.memberSince,
    required this.description,
    required this.problemType,
    required this.requestType,
    required this.images,
    required this.imagesCount,
    required this.status,
    required this.createdAt,
    this.city,
    this.location,
    this.distance,
  });
}
