import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.isChat, required this.request});
  final bool isChat;
  final RequestModel request;

  @override
  Widget build(BuildContext context) {
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
          right: BorderSide(
            color: isChat ? AppColors.yellowNormal : AppColors.blueNormal,
            width: 4,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.userName,
                    style: TextStyles.cairoBold16.copyWith(
                      color: AppColors.blueDarkActive,
                    ),
                  ),
                  Text(
                    request.distance != null
                        ? "${request.city}, ${request.distance} km away "
                        : request.city,
                    style: TextStyles.cairoRegular11.copyWith(
                      color: AppColors.whiteDarkActive,
                    ),
                  ),
                ],
              ),

              Spacer(),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isChat ? AppColors.yellowLight : AppColors.blueLight,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  isChat ? "مساعدة أونلاين" : "مساعدة اوفلاين",
                  style: TextStyles.bold11Tajawal.copyWith(
                    color: isChat
                        ? AppColors.yellowNormal
                        : AppColors.blueNormal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text(
            request.description,
            style: TextStyles.cairoMedium12.copyWith(
              color: AppColors.whiteDarker,
            ),
          ),
          SizedBox(height: 15.h),
          CustomElevatedButton(
            text: "تفاصيل المشكلة",
            radius: CustomRadius.r1,
            fun: () {
              Navigator.of(
                context,
              ).pushNamed('RequestDetails', arguments: request);
            },
            height: 41,
            fontStyle: TextStyles.cairoBold12,
            backgColor: isChat ? AppColors.yellowNormal : AppColors.blueNormal,
            prefixIcon: Icon(
              Icons.handshake_outlined,
              size: 12.sp,
              color: AppColors.whiteLight,
            ),
          ),

          // SizedBox(
          //   width: double.infinity,
          //   height: 41.h,
          //   child: ElevatedButton.icon(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: AppColors.yellowNormal,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: CustomRadius.card12,
          //       ),
          //     ),
          //     icon: Icon(Icons.details, color: Colors.white, size: 18.sp),
          //     label: Text(
          //       "تفاصيل المشكلة",
          //       style: TextStyles.cairoBold12.copyWith(color: AppColors.whiteLight),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
