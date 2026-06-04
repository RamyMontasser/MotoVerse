import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/constants/constants.dart';
// import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/my_offers_cubit.dart';

class MyOfferPageCard extends StatelessWidget {
  const MyOfferPageCard({super.key, required this.offerModel});

  final OfferModel offerModel;

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
    Color statusColor;
    String statusText;

    switch (offerModel.status) {
      case 'accepted':
        statusColor = AppColors.greenNormal;
        statusText = 'مقبول';
        break;
      case 'rejected':
        statusColor = AppColors.redDark;
        statusText = 'مرفوض';
        break;
      case 'completed':
        statusColor = AppColors.blueNormal;
        statusText = 'مكتمل';
        break;
      case 'pending':
      default:
        statusColor = AppColors.yellowNormal;
        statusText = 'قيد الانتظار';
        break;
    }

    // String buttonText = offerModel.status == 'accepted' ? 'الذهاب للدردشة' : 'عرض التفاصيل';

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
              // Status Badge

              // SizedBox(width: 8.w),
              // Delete Icon (visible for pending)
              // if (offerModel.status == 'pending')
              // InkWell(
              //   onTap: () {
              //     context.read<MyOffersCubit>().deleteOffer(offerId: offerModel.id);
              //   },
              //   borderRadius: CustomRadius.auth,
              //   child: Padding(
              //     padding: EdgeInsets.all(4.r),
              //     child: Icon(Icons.delete_outline, color: AppColors.redDark, size: 20.sp),
              //   ),
              // ),
              // const Spacer(),
              CircleAvatar(
                radius: 26.r,
                backgroundColor: statusColor,
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.blueLight,
                  backgroundImage:
                      offerModel.helperImage != null &&
                          offerModel.helperImage!.isNotEmpty
                      ? NetworkImage(
                          offerModel.helperImage!.startsWith('http')
                              ? offerModel.helperImage!
                              : "${AppConstants.baseUrl}${offerModel.helperImage!}",
                        )
                      : null,
                  child:
                      offerModel.helperImage == null ||
                          offerModel.helperImage!.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                offerModel.helperName,
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueDarkActive,
                ),
              ),

              Spacer(),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  statusText,
                  style: TextStyles.cairoBold12.copyWith(color: statusColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Details Box
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.05),
              //  AppColors.blueGrey.withValues(alpha: 0.5),
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
                      offerModel.distance != null
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
                      _formatArabicDateTime(offerModel.createdAt),
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
            radius: CustomRadius.card12,
            fun: () {
              final locationState = context.read<CurrentLocationCubit>().state;
              double latitude = 0.0;
              double longitude = 0.0;
              if (locationState is CurrentLocationSuccess) {
                latitude = locationState.currentLocation.latitude;
                longitude = locationState.currentLocation.longitude;
              }

              context.read<MyOffersCubit>().getRequestDetails(
                requestId: offerModel.request,
                latitude: latitude,
                longitude: longitude,
              );
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
