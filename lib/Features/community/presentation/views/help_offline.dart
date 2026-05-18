import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/community/presentation/widgets/car_info_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/request_location_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/user_contact_info.dart';

import 'package:motoverse/Features/community/data/models/request_model.dart';

class HelpOffline extends StatelessWidget {
  const HelpOffline({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestModel? request =
        ModalRoute.of(context)?.settings.arguments as RequestModel?;

    // Default request for demo purposes if not passed
    final displayRequest = request ??
        RequestModel(
          id: 0,
          userId: 0,
          userImage: '',
          userName: 'أحمد منصور',
          memberSince: 2024,
          city: 'دمياط',
          description: '',
          problemType: '',
          requestType: 'offline',
          images: [],
          imagesCount: 0,
          status: '',
          createdAt: '',
          distance: 2.5,
        );

    return Scaffold(
      body: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          child: Column(
            children: [
              RequestLocationCard(isAccepted: true, request: displayRequest),
              SizedBox(height: 15.h),

              UserContactInfo(request: displayRequest),

              SizedBox(height: 15.h),

              CarInfoCard(),

              SizedBox(height: 20.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.blueGrey,
                  borderRadius: CustomRadius.r1,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 16.sp,
                      color: AppColors.blueNormal,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'جميع تفاصيل العميل والبيانات الشخصية محمية ومؤمنة .',
                      style: TextStyles.cairoRegular11.copyWith(
                        color: AppColors.blueNormal,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h,),

              CustomElevatedButton(
                text: 'بدأ التحرك', 
                radius: CustomRadius.card12, 
                fun: (){}, 
                height: 50, 
                fontStyle: TextStyles.cairoBold16,
                )
            ],
          ),
        ),
      ),
    );
  }
}
