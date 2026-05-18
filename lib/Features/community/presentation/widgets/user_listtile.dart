import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';

class UserListtile extends StatelessWidget {
  const UserListtile({super.key, required this.request, });
  final RequestModel request;
  

  @override
  Widget build(BuildContext context) {
    bool isOnline = request.requestType == 'online';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundImage:
              request.userImage != null && request.userImage!.isNotEmpty
              ? NetworkImage(
                  request.userImage!.startsWith('http')
                      ? request.userImage!
                      : "${AppConstants.baseUrl}/${request.userImage!}",
                )
              : null,
          child: request.userImage == null || request.userImage!.isEmpty
              ? const Icon(Icons.person)
              : null,
        ),
        SizedBox(width: 10.w),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.userName,
              style: TextStyles.cairoBold16.copyWith(
                color: AppColors.blueDarkActive,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.whiteDarkActive,
                  size: 13.sp,
                ),

                SizedBox(width: 2.w),

                Text(
                  "${request.city}, ${request.distance} km away ",
                  style: TextStyles.cairoRegular11.copyWith(
                    color: AppColors.whiteDarkActive,
                  ),
                ),
              ],
            ),
          ],
        ),

        Spacer(),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isOnline ? AppColors.yellowLight : AppColors.blueLight,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            isOnline ? "مساعدة أونلاين" : "مساعدة اوفلاين",
            style: TextStyles.bold11Tajawal.copyWith(
              color: isOnline ? AppColors.yellowNormal : AppColors.blueNormal,
            ),
          ),
        ),
      ],
    );
  }
}
