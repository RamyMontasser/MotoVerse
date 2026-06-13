import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/presentation/views/user_requests_screen.dart';
import 'package:motoverse/generated/l10n.dart';

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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  const UserRequestsScreen(initialCategory: 1),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 48.w,
                height: 48.h,
                decoration: const BoxDecoration(
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
            Expanded(
              flex: 4,
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
                    S.of(context).ongoingRequests,
                    style: TextStyles.cairoBold14.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                text: S.of(context).trackRequest,
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
          ],
        ),
      ),
    );
  }
}
