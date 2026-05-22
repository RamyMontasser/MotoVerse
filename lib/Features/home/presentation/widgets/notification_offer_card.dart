import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/notification_cubit.dart';

class NotificationOfferCard extends StatelessWidget {
  const NotificationOfferCard({
    super.key,
    required this.isOffline,
    required this.offerModel,
  });

  final bool isOffline;
  final OfferModel offerModel;

  @override
  Widget build(BuildContext context) {
    // debugPrint(offerModel.toString());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: CustomRadius.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.whiteNormalActive),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundColor: AppColors.blueLight,
                backgroundImage: offerModel.helperImage != null && offerModel.helperImage!.isNotEmpty
                    ? NetworkImage(offerModel.helperImage!)
                    : null,
                child: offerModel.helperImage == null || offerModel.helperImage!.isEmpty
                    ? const Icon(Icons.person)
                    : null,
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offerModel.helperName,
                    style: TextStyles.cairoBold18.copyWith(
                      color: AppColors.blueDarkActive,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '4.8',
                        style: TextStyles.cairoBold13.copyWith(
                          color: AppColors.blueDarkActive,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.star,
                        color: AppColors.yellowNormal,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
          if (isOffline) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                _buildInfoBox(
                  'وقت الوصول',
                  '${offerModel.estimatedMinutes ?? '0'} د',
                  Icons.access_time,
                ),
                SizedBox(width: 10.w),
                _buildInfoBox(
                  'المسافة',
                  '${offerModel.distance ?? '0'} km',
                  Icons.location_on_outlined,
                ),
              ],
            ),
          ],
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildActionCardButton(
                'قبول',
                isOffline ? AppColors.yellowNormal : AppColors.blueNormal,
                AppColors.whiteLight,
                () {
                  context.read<NotificationCubit>().updateOfferStatus(
                        offerId: offerModel.id,
                        status: 'accepted',
                      );
                },
              ),
              SizedBox(width: 10.w),
              _buildActionCardButton(
                'رفض',
                AppColors.blueGrey,
                AppColors.blueNormal,
                () {
                  debugPrint(offerModel.id.toString());
                  context.read<NotificationCubit>().updateOfferStatus(
                        offerId: offerModel.id,
                        status: 'rejected',
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.blueGrey,
          borderRadius: CustomRadius.card12,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyles.cairoBold12.copyWith(
                color: AppColors.whiteDarkActive,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: AppColors.blueNormal),
                SizedBox(width: 4.w),
                Text(
                  value,
                  style: TextStyles.cairoBold13.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCardButton(
    String text,
    Color bg,
    Color textColor,
    VoidCallback fun,
  ) {
    return Expanded(
      child: CustomElevatedButton(
        text: text,
        radius: CustomRadius.card12,
        fun: fun,
        backgColor: bg,
        foregColor: textColor,
        height: 40,
        fontStyle: TextStyles.cairoBold16,
      ),
    );
  }
}
