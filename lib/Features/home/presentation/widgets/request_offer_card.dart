import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/home/data/models/offer_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/notification_cubit.dart';
import 'package:motoverse/generated/l10n.dart';

class RequestOfferCard extends StatelessWidget {
  const RequestOfferCard({
    super.key,
    required this.isOffline,
    required this.offerModel,
    this.request,
    this.isAccepted = false,
  });

  final bool isOffline;
  final OfferModel offerModel;
  final bool isAccepted;
  final RequestModel? request;

  @override
  Widget build(BuildContext context) {
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
                        offerModel.averageRating,
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
                  S.of(context).arrivalTime,
                  S
                      .of(context)
                      .minutesDuration(offerModel.estimatedMinutes ?? '0'),
                  Icons.access_time,
                ),
                SizedBox(width: 10.w),
                _buildInfoBox(
                  S.of(context).distanceLabel,
                  S.of(context).distanceKm(offerModel.distance ?? '0'),
                  Icons.location_on_outlined,
                ),
              ],
            ),
          ],
          SizedBox(height: 12.h),

          if (isAccepted)
            CustomElevatedButton(
              text: S.of(context).offerAccepted,
              radius: CustomRadius.card12,
              fun: () {
                Navigator.pushNamed(
                  context,
                  'HelpOffline',
                  arguments: [request, offerModel, false],
                );
              },
              backgColor: AppColors.greenNormal,
              foregColor: AppColors.whiteLight,
              height: 48,
              fontStyle: TextStyles.cairoBold16,
            ),

          if (!isAccepted)
            Row(
              children: [
                _buildActionCardButton(
                  S.of(context).accept,
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
                  S.of(context).reject,
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
