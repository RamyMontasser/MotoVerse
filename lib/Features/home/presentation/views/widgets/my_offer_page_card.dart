import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/my_offers_cubit.dart';

class MyOfferPageCard extends StatelessWidget {
  const MyOfferPageCard({
    super.key,
    required this.offerModel,
  });

  final OfferModel offerModel;

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
      case 'pending':
      default:
        statusColor = AppColors.orangeNormal;
        statusText = 'قيد الانتظار';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: CustomRadius.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.whiteNormalActive),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  statusText,
                  style: TextStyles.cairoBold12.copyWith(color: statusColor),
                ),
              ),
              const Spacer(),
              Text(
                offerModel.createdAt.substring(0, 10), // Assuming ISO date string
                style: TextStyles.cairoMedium12.copyWith(color: AppColors.whiteDarkActive),
              ),
              SizedBox(width: 10.w),

              if(offerModel.status == 'pending')
              InkWell(
                onTap: () {
                  context.read<MyOffersCubit>().deleteOffer(offerId: offerModel.id);
                },
                borderRadius: CustomRadius.auth,
                child: Icon(Icons.delete_outline, color: AppColors.redDark),
              )
              // IconButton(
              //   onPressed: () {
              //     context.read<MyOffersCubit>().deleteOffer(offerId: offerModel.id);
              //   },
              //   icon: const Icon(Icons.delete_outline, color: AppColors.redDark),
              //   padding: EdgeInsets.zero,
              //   constraints: const BoxConstraints()
                
              // ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: AppColors.blueGrey,
                child: const Icon(Icons.request_page_outlined, color: AppColors.blueNormal),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'طلب رقم  ${offerModel.request}',
                      style: TextStyles.cairoBold14.copyWith(color: AppColors.blueDarkActive),
                    ),
                    if(offerModel.distance != null)
                    Text(
                      'المسافة المقدرة: ${offerModel.distance} كم',
                      style: TextStyles.cairoMedium12.copyWith(color: AppColors.whiteDarkActive),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (offerModel.status == 'accepted') ...[
            SizedBox(height: 12.h),
            CustomElevatedButton(
              text: 'الذهاب للدردشة',
              radius: CustomRadius.card12,
              fun: () {
                context.read<MyOffersCubit>().getRequestDetails(
                  requestId: offerModel.request,
                );
              },
              backgColor: AppColors.greenNormal,
              foregColor: AppColors.whiteLight,
              height: 40,
              fontStyle: TextStyles.cairoBold14,
            ),
          ],
        ],
      ),
    );
  }
}
