import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class ProfileUserInfoWidget extends StatelessWidget {
  const ProfileUserInfoWidget({
    super.key,
    required this.name,
    required this.memberSince,
  });

  final String name;
  final String memberSince;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 12.h),
        Text(
          name,
          style: TextStyles.cairoBold22.copyWith(
            color: AppColors.blueNormal,
          ),
        ),
        Text(
          'انضم منذ $memberSince',
          style: TextStyles.cairoRegular14.copyWith(
            color: AppColors.whiteDarker,
          ),
        ),
      ],
    );
  }
}
