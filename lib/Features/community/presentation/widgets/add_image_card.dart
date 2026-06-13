import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/generated/l10n.dart';

class AddImageCard extends StatelessWidget {
  const AddImageCard({super.key, required this.onTap, this.hight});
  final VoidCallback onTap;
  final double? hight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          padding: EdgeInsets.zero,
          color: AppColors.blueLightActive,
          dashPattern: const [8, 4],
          strokeWidth: 2.w,
          borderPadding: EdgeInsets.zero,
          radius: Radius.circular(13.r),
        ),

        child: Container(
          // width: 107.w,
          height: hight,
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          decoration: BoxDecoration(
            color: AppColors.whiteLightActive,
            borderRadius: CustomRadius.card12,
            // border: Border.all(
            //   color: AppColors.blueLightHover,
            //   style: BorderStyle.solid,
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo_outlined,
                color: Colors.blueGrey,
                size: 22.sp,
              ),
              // SizedBox(height: 4.h),
              Text(
                S.of(context).add,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
