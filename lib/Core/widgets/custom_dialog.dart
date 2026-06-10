// verification_loading_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.isSuccess,
    // required this.title,
    // required this.desc,
    // required this.buttonText,
  });

  final bool isSuccess;
  // final String title;
  // final String desc;
  // final String buttonText;

  static void show({
    required BuildContext context,
    required bool isSuccess,
    // required String title,
    // required String desc,
    // required String buttonText,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        isSuccess: isSuccess,
        // title: title,
        // desc: desc,
        // buttonText: buttonText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteLight,
      shape: RoundedRectangleBorder(borderRadius: CustomRadius.card),
      elevation: 8,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSuccess
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.greenLight,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_circle_outline,
                        color: AppColors.greenNormal,
                        size: 65.sp,
                      ),
                    ),
                  )
                : SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: CircularProgressIndicator(
                      color: AppColors.blueNormal,
                      strokeWidth: 4.w,
                    ),
                  ),

            SizedBox(height: 10.h),

            Text(
              isSuccess ? 'تم التأكيد بنجاح' : 'جاري التحقق من الهوية',
              style: TextStyles.cairoBold24.copyWith(
                color: AppColors.blueNormal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),

            Text(
              isSuccess
                  ? 'تهانينا!\nتم تأكيد هوية حسابك'
                  : 'يرجي الانتظار بضع لحظات',
              style: TextStyles.cairoRegular14.copyWith(
                color: AppColors.whiteDarkActive,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            if (isSuccess)
              CustomElevatedButton(
                text: 'العودة للرئيسية',
                fun: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Navigator.of(context).popAndPushNamed('HelpOffline');
                },
                height: 48,
                radius: BorderRadius.circular(12.r),
                withBorder: false,
                backgColor: AppColors.greenNormal,
                foregColor: AppColors.whiteLight,
                fontStyle: TextStyles.cairoBold16,
              ),
          ],
        ),
      ),
    );
  }
}
