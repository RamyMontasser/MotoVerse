import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class CustomSecSliverAppbar extends StatelessWidget {
  const CustomSecSliverAppbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false, // يختفي تمامًا لما تنزل
      floating: true, // يظهر بسرعة لما تطلع لفوق شوية
      snap: true, // يخليه يظهر بسلاسة
      // expandedHeight: 70.h,
      foregroundColor: AppColors.whiteLight,
      centerTitle: true,
      title: Text(title, style: TextStyles.cairoMedium12),
      // actions: [
      //   IconButton(
      //     // onPressed: action ?? () {},
      //     onPressed: () {},
      //     icon:
      //         // actionicon ??
      //         SvgPicture.asset(
      //           'assets/images/notification.svg',
      //           width: 24.w,
      //           height: 24.h,
      //         ),
      //   ),
      // ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.blueDarker,
                AppColors.blueNormal,
                AppColors.blueNormal,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
