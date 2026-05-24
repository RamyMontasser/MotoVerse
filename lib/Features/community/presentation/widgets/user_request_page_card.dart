import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';

class UserRequestPageCard extends StatelessWidget {
  const UserRequestPageCard({super.key, required this.request});

  final RequestModel request;

  String _formatArabicDateTime(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt).toLocal();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

      String dayStr;
      if (dateToCheck == today) {
        dayStr = 'اليوم';
      } else if (dateToCheck == today.subtract(const Duration(days: 1))) {
        dayStr = 'أمس';
      } else {
        dayStr = '${dateTime.year}/${dateTime.month}/${dateTime.day}';
      }

      int hour = dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'مساءً' : 'صباحاً';
      if (hour > 12) hour -= 12;
      if (hour == 0) hour = 12;

      return '$dayStr، $hour:$minute $period';
    } catch (_) {
      if (createdAt.length >= 10) {
        return createdAt.substring(0, 10);
      }
      return createdAt;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isOffline = request.requestType == 'offline';
    final Color statusColor = isOffline
        ? AppColors.blueNormal
        : AppColors.yellowNormal;
    final String statusText = isOffline ? 'أوفلاين' : 'أونلاين';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: CustomRadius.card12,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDarker.withAlpha(30),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border(
          left: isEN()
              ? BorderSide(color: statusColor, width: 4)
              : BorderSide.none,
          right: isEN()
              ? BorderSide.none
              : BorderSide(color: statusColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: CustomRadius.card12,
                  color: statusColor.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: isOffline
                      ? Icon(
                          Icons.location_on_outlined,
                          size: 26.sp,
                          color: statusColor,
                        )
                      : Icon(
                          Icons.chat_outlined,
                          size: 26.sp,
                          color: statusColor,
                        ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'مساعدة $statusText',
                  style: TextStyles.cairoBold16.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),
              ),
              if (request.status == 'pending' || request.status == 'accepted')
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 26.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.greenLight,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'نشط',
                    style: TextStyles.cairoBold12.copyWith(
                      color: AppColors.greenNormal,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'نوع المساعدة',
                      style: TextStyles.cairoRegular14.copyWith(
                        color: AppColors.whiteDarkActive,
                      ),
                    ),
                    Text(
                      request.requestType == 'offline'
                          ? 'مساعدة ميدانية'
                          : 'مساعدة أونلاين',
                      style: TextStyles.cairoRegular14.copyWith(
                        color: AppColors.blueNormal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'التاريخ والوقت',
                      style: TextStyles.cairoRegular14.copyWith(
                        color: AppColors.whiteDarkActive,
                      ),
                    ),
                    Text(
                      _formatArabicDateTime(request.createdAt),
                      style: TextStyles.cairoRegular14.copyWith(
                        color: AppColors.blueDarker,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          CustomElevatedButton(
            text: 'عرض التفاصيل',
            radius: CustomRadius.r2,
            fun: () {
              Navigator.of(
                context,
              ).pushNamed('RequestDetails', arguments: request);
            },
            backgColor: statusColor,
            foregColor: AppColors.whiteLight,
            height: 40,
            fontStyle: TextStyles.cairoBold14,
          ),
        ],
      ),
    );
  }

  bool isEN() {
    return Intl.getCurrentLocale() == 'en';
  }
}
