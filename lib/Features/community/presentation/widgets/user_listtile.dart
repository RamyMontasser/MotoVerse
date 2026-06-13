import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/generated/l10n.dart';

class UserListtile extends StatelessWidget {
  const UserListtile({super.key, required this.request});
  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    final bool isOnline = request.requestType == 'online';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundColor: AppColors.blueLight,
          backgroundImage:
              request.userImage != null && request.userImage!.isNotEmpty
              ? NetworkImage(
                  request.userImage!.startsWith('http')
                      ? request.userImage!
                      : "${AppConstants.baseUrl}${request.userImage!}",
                )
              : null,
          child: request.userImage == null || request.userImage!.isEmpty
              ? const Icon(Icons.person)
              : null,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                request.userName,
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueDarkActive,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.whiteDarkActive,
                      size: 13.sp,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      isOnline
                          ? request.city
                          : "${request.city}, ${S.of(context).away(request.distance ?? '')}",
                      style: TextStyles.cairoRegular11.copyWith(
                        color: AppColors.whiteDarkActive,
                      ),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: isOnline ? AppColors.yellowLight : AppColors.blueLight,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            isOnline ? S.of(context).onlineHelp : S.of(context).offlineHelp,
            style: TextStyles.bold11Tajawal.copyWith(
              color: isOnline ? AppColors.yellowNormal : AppColors.blueNormal,
            ),
          ),
        ),
      ],
    );
  }
}
