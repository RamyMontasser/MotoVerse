import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';

class CommunityOption extends StatelessWidget {
  const CommunityOption({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.description,
    required this.buttonText,
    required this.onPressed,  this.backgColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final Color? backgColor;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLightHover,
        borderRadius: CustomRadius.card12,
        border: BoxBorder.all(color: AppColors.whiteNormalActive, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            
            child: Icon(icon, color: iconColor,size: 30.sp,),
            
            // SvgPicture.asset(
            //   iconPath,
            //   colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            //   width: 32.w,
            //   height: 32.h,
            // ),
          ),
          SizedBox(height: 5.h),

          Text(
            description,
            style: TextStyles.cairoRegular16.copyWith(
              color: AppColors.blueDarkHover,
              height: 1.5, 
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.h),

          CustomElevatedButton(
            fun: onPressed,
            text: buttonText,
            backgColor: backgColor?? AppColors.blueNormal, 
            radius: CustomRadius.card12, 
            height: 40.h, 
            width: 201.w,
            withBorder: false, 
            fontStyle: TextStyles.cairoBold16.copyWith(
              color: AppColors.whiteLight,
            ),
          ),
        ],
      ),
    );
  }
}