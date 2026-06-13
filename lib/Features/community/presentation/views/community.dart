import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/community/presentation/widgets/community_option.dart';
import 'package:motoverse/Features/community/presentation/widgets/hot_line_footer.dart';
import 'package:motoverse/generated/l10n.dart';

class CommunityMain extends StatelessWidget {
  const CommunityMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              Text(
                S.of(context).welcomeTo,
                style: TextStyles.cairoBold24.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyles.cairoBold24,
                  children: [
                    TextSpan(
                      text: "Motoverse ",
                      style: TextStyle(color: AppColors.yellowNormal),
                    ),
                    TextSpan(
                      text: "community",
                      style: TextStyle(color: AppColors.blueNormal),
                    ),
                  ],
                ),
              ),
              Text(
                S.of(context).motoverseCommunitySub,
                style: TextStyles.cairoRegular14.copyWith(
                  color: AppColors.whiteDarkActive,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              CommunityOption(
                icon: Icons.car_crash_outlined,
                iconColor: AppColors.redNormal,
                iconBgColor: AppColors.redLight,
                description: S.of(context).requestHelpDesc,
                buttonText: S.of(context).requestHelpBtn,
                onPressed: () {
                  Navigator.of(context).pushNamed('RequestHelp1');
                },
              ),
              SizedBox(height: 20.h),
              CommunityOption(
                icon: Icons.handshake_outlined,
                iconColor: AppColors.yellowNormal,
                iconBgColor: AppColors.yellowLight,
                description: S.of(context).viewRequestsDesc,
                buttonText: S.of(context).viewRequestsBtn,
                onPressed: () {
                  Navigator.of(context).pushNamed('AvailableRequests');
                },
              ),
              SizedBox(height: 20.h),
              HotLineFooter(),
              SizedBox(height: 70.h),
            ],
          ),
        ),
      ),
    );
  }
}
