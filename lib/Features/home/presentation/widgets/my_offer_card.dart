import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';

class MyOfferCard extends StatelessWidget {
  const MyOfferCard({super.key, required this.offers});
  final List<OfferModel> offers;

  @override
  Widget build(BuildContext context) {
    List<OfferModel> acceptedOffer = offers.where((request) => request.status == 'accepted').toList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: CustomRadius.card12,
        color: AppColors.whiteLight,
        border: Border.all(color: AppColors.whiteNormalActive, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.15),
            blurRadius: 1.5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('MyOffersPage');
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 48.w,
                height: 48.h,
                decoration: const BoxDecoration(
                  color: AppColors.greenLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_offer_outlined,
                  color: AppColors.greenNormal,
                  size: 26.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Middle: Text Info
            Expanded(
              flex: 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
                      color: AppColors.greenNormal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'عروضي الحالية',
                            style: TextStyles.cairoBold14.copyWith(
                              color: AppColors.blueNormal,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '(${offers.length})',
                            style: TextStyles.cairoMedium12.copyWith(
                              color: AppColors.whiteDarkActive,
                            ),
                          ),
                        ],
                      ),
                      if(acceptedOffer.isNotEmpty)
                      Text(
                        'يوجد محادثة نشطة',
                        style: TextStyles.cairoRegular14.copyWith(
                          color: AppColors.greenNormal,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                text: 'عرض العروض',
                radius: CustomRadius.card12,
                fun: () {
                  Navigator.pushNamed(context, 'MyOffersPage');
                },
                height: 32,
                fontStyle: TextStyles.cairoBold12,
                backgColor: AppColors.greenNormal,
                // padding: EdgeInsets.symmetric(horizontal: 14.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
