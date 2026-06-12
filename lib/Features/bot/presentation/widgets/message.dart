import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.messageContent});
  final String messageContent;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isEN() ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isEN() ? 12.r : 0.r),
            topRight: Radius.circular(isEN() ? 0.r : 12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          ),
          color: AppColors.blueNormal,
        ),
        child: Text(
          messageContent,
          style: TextStyles.cairoRegular14.copyWith(
            color: AppColors.whiteLight,
          ),
        ),
      ),
    );
  }

  bool isEN() {
    return Intl.getCurrentLocale() == 'en';
  }
}
