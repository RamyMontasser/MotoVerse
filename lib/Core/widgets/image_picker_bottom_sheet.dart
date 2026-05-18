import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/services/image_picker_service.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(XFile?) onImagePicked;

  const ImagePickerBottomSheet({super.key, required this.onImagePicked});

  static void show({required BuildContext context, required Function(XFile?) onImagePicked}){
    showModalBottomSheet(
    context: context,
    builder: (context) => ImagePickerBottomSheet(
      onImagePicked: onImagePicked)
    );
  }

  @override
  Widget build(BuildContext context) {
    final ImagePickerService imageService = getIt<ImagePickerService>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSourceTile(
            context: context,
            title: 'الكاميرا',
            icon: Icons.camera_alt,
            source: ImageSource.camera,
            service: imageService,
          ),
          _buildSourceTile(
            context: context,
            title: 'المعرض',
            icon: Icons.photo_library,
            source: ImageSource.gallery,
            service: imageService,
          ),
        ],
      ),
    );
  }

  Widget _buildSourceTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required ImageSource source,
    required ImagePickerService service,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.yellowNormal),
      title: Text(
        title,
        style: TextStyles.cairoBold13.copyWith(color: AppColors.blueDarkActive),
      ),
      onTap: () async {
        Navigator.pop(context); 
        final response = await service.pickImage(source: source);
        
          onImagePicked(response); 
      },
    );
  }
}
