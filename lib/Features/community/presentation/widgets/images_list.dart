import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/widgets/image_picker_bottom_sheet.dart';
import 'package:motoverse/Features/community/presentation/widgets/add_image_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/image_card.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({
    super.key,
    required this.onImagePicked,
    required this.onDelete,
    required this.pickedImages,
  });
  final List<XFile> pickedImages;
  final Function(XFile) onImagePicked;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 107.h,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: pickedImages.length + 1,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AddImageCard(
              onTap: () => ImagePickerBottomSheet.show(
                context: context,
                onImagePicked: (image) {
                  if (image != null) {
                    onImagePicked(image);
                  }
                },
              ),
            );
          }
          final imageIndex = index - 1;
          return ImageCard(image: pickedImages[imageIndex], onDelete: () {onDelete(imageIndex);});
        },
      ),
    );
  }
}
