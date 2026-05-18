import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage({required ImageSource source}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 50, 
        maxWidth: 1000,
      );
      return image;
    } catch (e) {
      // print("Error picking image: $e");
      return null;
    }
  }

  Future<List<XFile>> pickMultiImage() async {
    try {
      return await _picker.pickMultiImage(imageQuality: 50);
    } catch (e) {
      // print("Error picking multi images: $e");
      return [];
    }
  }
}
