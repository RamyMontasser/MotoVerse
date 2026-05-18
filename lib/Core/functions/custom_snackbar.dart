import 'package:flutter/material.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

void customSnackBar({
  required BuildContext context,
  required String msg,
  required bool isDone,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: TextStyles.cairoRegular11.copyWith(
          color: AppColors.whiteLightActive,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      backgroundColor: isDone ? AppColors.greenNormal : Colors.red,
      duration: Duration(seconds: 3),
    ),
  );
}
