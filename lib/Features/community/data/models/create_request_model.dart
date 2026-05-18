import 'package:image_picker/image_picker.dart';

class CreateRequestModel {
  final String description;
  final String problemType;
  final String requestType;
  final double? latitude;
  final double? longitude;
  final String? city;
  final List<XFile> images;

  CreateRequestModel({
    required this.description,
    required this.problemType,
    required this.requestType,
    this.latitude,
    this.longitude,
    this.city,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'problem_type': problemType,
      'request_type': requestType,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'images': images,
    };
  }
}
