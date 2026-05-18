import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';

class CustomSliverAppbar extends StatelessWidget {
  const CustomSliverAppbar({super.key, this.pinned});
  final bool? pinned;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Navigator.canPop(context)? IconButton(
    icon: const Icon(Icons.arrow_back_ios_new_rounded), 
    onPressed: () => Navigator.pop(context),
  ): null,
      pinned: pinned?? false, 
      floating: pinned == true? false: true, 
      snap: pinned == true ? false : true, 
      surfaceTintColor: AppColors.whiteLight,
      expandedHeight: 60.h,
      foregroundColor: AppColors.yellowNormal,
      centerTitle: true,
      title: SvgPicture.asset(
        'assets/images/motoverse.svg',
        width: 131.w,
        height: 20.h,
      ),
      actions: [
        if (!Navigator.canPop(context))
         IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'NotificationPage');
          },
          icon:
              SvgPicture.asset(
                'assets/icons/home/notification.svg',
                width: 24.w,
                height: 24.h,
              ),
        ),
      ],
      backgroundColor: AppColors.whiteLight,
      // flexibleSpace: FlexibleSpaceBar(
      //   background: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         begin: Alignment.topRight,
      //         end: Alignment.bottomLeft,
      //         colors: [
      //           AppColors.redGradianDark,
      //           AppColors.blueNormal,
      //           AppColors.blueNormal,
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
