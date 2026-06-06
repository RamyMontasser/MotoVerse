import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';


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
        // SizedBox(
        //   width: double.infinity,
        // child:
        CustomElevatedButton(
          text: 'حفظ التغييرات',
          backgColor: AppColors.blueNormal,
          radius: CustomRadius.card12,
          fun: onSave,
          height: 52.h,
          fontStyle: TextStyles.cairoBold14.copyWith(
            color: AppColors.whiteLight,
          ),
        ),
        //  ElevatedButton(
        //   onPressed: onSave,
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: AppColors.blueDarkActive,
        //     elevation: 0,
        //     padding: EdgeInsets.symmetric(vertical: 14.h),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12.r),
        //     ),
        //   ),
        //   child: Text(
        //     'حفظ التغييرات',
        //     style: TextStyles.cairoBold16.copyWith(color: Colors.white),
        //   ),
        // ),
        // ),
        SizedBox(height: 10.h),
        TextButton(
          onPressed: onCancel,
          child: Text(
            'إلغاء',
            style: TextStyles.cairoBold16.copyWith(color: AppColors.blueNormal),
          ),
        ),
      ],
    );
  }
}
