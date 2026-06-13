import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/community/presentation/widgets/community_option.dart';
import 'package:motoverse/Features/community/presentation/widgets/hot_line_footer.dart';
import 'package:motoverse/generated/l10n.dart';

class RequestHelp1 extends StatelessWidget {
  const RequestHelp1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              CommunityOption(
                icon: Icons.location_on_outlined,
                iconColor: AppColors.blueNormal,
                iconBgColor: AppColors.blueLight,
                description: S.of(context).roadsideHelpDesc,
                buttonText: S.of(context).requestHelpButton,
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed('CreateRequest', arguments: true);
                },
              ),
              SizedBox(height: 20.h),

              CommunityOption(
                icon: Icons.message_outlined,
                iconColor: AppColors.yellowNormal,
                iconBgColor: AppColors.yellowLight,
                backgColor: AppColors.yellowNormal,
                description: S.of(context).onlineChatHelpDesc,
                buttonText: S.of(context).requestHelpButton,
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed('CreateRequest', arguments: false);
                },
              ),

              SizedBox(height: 20.h),

              const HotLineFooter(),

              SizedBox(height: 70.h),
            ],
          ),
        ),
      ),
    );
  }
}
