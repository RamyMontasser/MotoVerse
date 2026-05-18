import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/theme/app_colors.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.image, required this.onDelete});
  
  final XFile image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: 107.w,
        height: 105.h,
        child: GridTile(
          header: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              child: GestureDetector(
                onTap: onDelete,
                child: CircleAvatar(
                  radius: 10.r,
                  backgroundColor: Colors.black26,
                  child: Icon(
                    Icons.close,
                    size: 12.sp,
                    color: AppColors.whiteLight,fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          child: Image.file(
            File(image.path),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}