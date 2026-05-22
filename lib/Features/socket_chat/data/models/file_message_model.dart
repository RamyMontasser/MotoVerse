import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class FileMessageModel {
  final XFile file;
  final String fileType; // e.g., 'image' or 'audio'

  FileMessageModel({
    required this.file,
    required this.fileType,
  });

  /// Converts the file message model into a Dio [FormData] object for form-data uploads.
  /// Maps to both 'file_type' and 'file-type' to support varied backend expectations.
  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      ),
      'file_type': fileType,
      // 'file-type': fileType,
    });
  }

  /// Converts to JSON map representation.
  Map<String, dynamic> toJson() {
    return {
      'file': file.path,
      'file_type': fileType,
    };
  }

  /// Factory constructor to create a model from a map (if path-based).
  factory FileMessageModel.fromJson(Map<String, dynamic> json) {
    return FileMessageModel(
      file: XFile((json['file'] ?? '').toString()),
      fileType: (json['file_type'] ?? json['file-type'] ?? '').toString(),
    );
  }

  FileMessageModel copyWith({
    XFile? file,
    String? fileType,
  }) {
    return FileMessageModel(
      file: file ?? this.file,
      fileType: fileType ?? this.fileType,
    );
  }
}
