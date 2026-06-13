import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';


class ProfileSwitchItem extends StatelessWidget {
  const ProfileSwitchItem({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
      child: Row(
        children: [
          Icon(icon, color: AppColors.whiteDarker, size: 22.sp),

          SizedBox(width: 10.w),

          Text(
            title,
            style: TextStyles.cairoRegular15.copyWith(
              color: AppColors.blueDarker,
            ),
          ),

          const Spacer(),

          SizedBox(
            height: 24.h,
            child: Transform.scale(
              scale: 0.85,
              child: Switch(
                padding: EdgeInsets.zero,
                value: value,
                onChanged: onChanged,
                activeThumbColor: AppColors.whiteLight,
                activeTrackColor: AppColors.yellowNormal,
                inactiveThumbColor: AppColors.whiteLight,
                inactiveTrackColor: AppColors.whiteDark,
                trackOutlineWidth: WidgetStateProperty.all(0),
                trackOutlineColor:
                    WidgetStateProperty.all(Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
