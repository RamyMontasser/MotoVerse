import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/home/data/models/notificaion_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final String formattedTime = DateFormat(
      'hh:mm a',
    ).format(notification.createdAt.toLocal());
    // .format(notification.createdAt).toLowerCase();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: notification.backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              notification.icon,
              color: notification.iconColor,
              size: 22.sp,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, 
              children: [
                Text(
                  notification.title,
                  style: TextStyles.cairoBold14.copyWith(
                    color: AppColors.blueDarkHover,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.body,
                  style: TextStyles.cairoRegular13.copyWith(
                    color: AppColors.whiteDarkActive,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              formattedTime,
              style: TextStyles.cairoRegular11.copyWith(
                color: AppColors.whiteDarkHover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
