import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class FileMessageModel {
  final XFile file;
  final String fileType; 

  FileMessageModel({
    required this.file,
    required this.fileType,
  });

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

  Map<String, dynamic> toJson() {
    return {
      'file': file.path,
      'file_type': fileType,
    };
  }

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
