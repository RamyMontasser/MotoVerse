import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';

class RequestStatusCard extends StatelessWidget {
  const RequestStatusCard({super.key, required this.requests});
  final List<RequestModel> requests;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: CustomRadius.card12,
        color: AppColors.whiteLight,
        border: BoxBorder.all(color: AppColors.whiteNormalActive, width: 0.5),
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
          Navigator.of(context).pushNamed('UserRequests');
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.orangeLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.engineering_outlined,
                  color: AppColors.orangeNormal,
                  size: 26.sp,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Middle: Text Info
            Expanded(
              flex: 4,
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
                      color: AppColors.orangeNormal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'طلبات جارية',
                    style: TextStyles.cairoBold14.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                ],
              ),
              // Text(
              //   'طلب رقم #AC-8892',
              //   style: TextStyles.cairoMedium12.copyWith(
              //     color: AppColors.whiteDarkActive,
              //   ),
              // ),
              // ],
              // ),
            ),

            // const Spacer(),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                text: 'تتبع الطلب',
                radius: CustomRadius.card12,
                fun: () {
                  Navigator.pushNamed(
                    context,
                    'RequestOffersScreen',
                    arguments: requests,
                  );
                },
                height: 32,
                fontStyle: TextStyles.cairoBold12,
                backgColor: AppColors.yellowNormal,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
              ),
            ),

            // SizedBox(
            //   height: 40.h,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.orangeNormal,
            //       foregroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12.r),
            //       ),
            //       padding: EdgeInsets.symmetric(horizontal: 16.w),
            //       elevation: 0,
            //     ),
            //     child: Text(
            //       'تتبع الطلب',
            //       style: TextStyles.cairoBold12.copyWith(color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
