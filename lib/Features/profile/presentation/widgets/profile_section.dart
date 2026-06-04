import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';


class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  static Widget divider({double height = 1, double thickness = 0.5}) {
    return Divider(
      height: height,
      thickness: thickness,
      color: AppColors.whiteNormalHover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Text(
            title,
            style: TextStyles.cairoBold17.copyWith(
              color: AppColors.blueNormal,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            borderRadius: CustomRadius.card12,
            color: AppColors.whiteLight,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.03),
                blurRadius: 8.r,
                spreadRadius: 3.r,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
