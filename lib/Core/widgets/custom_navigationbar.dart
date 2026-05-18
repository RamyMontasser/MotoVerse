import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';

// ignore: must_be_immutable
class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex;
  final Function(int) onItemTapped;

  final List<String> icons = [
    'assets/icons/bar/home_bar.svg',
    'assets/icons/bar/ai_bar.svg',
    'assets/icons/bar/community_bar.svg',
    'assets/icons/bar/map_bar.svg',
    'assets/icons/bar/account_bar.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: AppColors.whiteLight,
          boxShadow: [
            BoxShadow(color: AppColors.blueDarker.withAlpha(70), blurRadius: 3),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(icons.length, (index) {
            bool isActive = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                onItemTapped(index);
                // isActive = true;
                // widget.selectedIndex = index;
                // Navigator.of(context).pushReplacementNamed(icons[index][0]);
              },
              child: SvgPicture.asset(
                icons[index],
                width: isActive ? 36 : 28,
                height: isActive ? 36 : 28,
                colorFilter: ColorFilter.mode(
                  isActive ? AppColors.blueNormal : AppColors.whiteDarkHover,
                  BlendMode.srcIn,
                ),
                // color: isActive ? AppColors.blueNormal : AppColors.redGreyDark,
              ),
            );
          }),
        ),
      ),
    );
  }
}
