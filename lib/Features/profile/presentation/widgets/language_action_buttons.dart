import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/generated/l10n.dart'; 

class LanguageActionButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const LanguageActionButtons({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          text: S.of(context).saveChanges, 
          backgColor: AppColors.blueNormal,
          radius: CustomRadius.card12,
          fun: onSave,
          height: 52.h,
          fontStyle: TextStyles.cairoBold14.copyWith(
            color: AppColors.whiteLight,
          ),
        ),
        SizedBox(height: 10.h),
        TextButton(
          onPressed: onCancel,
          child: Text(
            S.of(context).cancel,
            style: TextStyles.cairoBold16.copyWith(color: AppColors.blueNormal),
          ),
        ),
      ],
    );
  }
}
