import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    super.key,
    required this.imageUrl,
    this.onEditTap,
  });

  final String imageUrl;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.whiteLight,
                width: 4.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.1),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 55.r,
              backgroundColor: AppColors.yellowNormal,
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage(
                      imageUrl.startsWith('http')
                          ? imageUrl
                          : "${AppConstants.baseUrl}$imageUrl",
                    )
                  : null,
              child: imageUrl.isEmpty
                  ? Icon(
                      Icons.person,
                      size: 50.sp,
                      color: AppColors.yellowLight,
                    )
                  : null,
            ),
          ),
          GestureDetector(
            onTap: onEditTap,
            child: CircleAvatar(
              radius: 19.r,
              backgroundColor: AppColors.whiteLight,
              child: CircleAvatar(
                radius: 17.r,
                backgroundColor: AppColors.blueNormal,
                child: Icon(
                  Icons.mode_edit_outline_outlined,
                  size: 19.sp,
                  color: AppColors.blueLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
