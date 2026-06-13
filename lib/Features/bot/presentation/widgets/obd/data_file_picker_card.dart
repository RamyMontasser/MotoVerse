import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
// import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/generated/l10n.dart';

class DataFilePickerCard extends StatelessWidget {
  final bool hasFile;
  final VoidCallback onPickFile;
  // final VoidCallback onReuploadFile;

  const DataFilePickerCard({
    super.key,
    required this.hasFile,
    required this.onPickFile,
    // required this.onReuploadFile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasFile ? null : onPickFile,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          padding: EdgeInsets.zero,
          color: AppColors.yellowNormal,
          dashPattern: const [7, 4],
          strokeWidth: 2.w,
          borderPadding: EdgeInsets.zero,
          radius: Radius.circular(16.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 28.w,
            vertical: hasFile ? 20.h : 35.h,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.orangeLight.withValues(alpha: 0.4),
            borderRadius: CustomRadius.card12,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _buildInitialState(context),
        ),
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 32.r,
          backgroundColor: AppColors.yellowLightActive,
          child: Icon(
            Icons.upload_file_outlined,
            color: AppColors.yellowNormal,
            size: 32.r,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          S.of(context).addDataFile,
          style: TextStyles.cairoBold16.copyWith(color: AppColors.blueDark),
        ),
        SizedBox(height: 6.h),
        Text(
          S.of(context).uploadVehicleDiagnosticFiles,
          textAlign: TextAlign.center,
          style: TextStyles.cairoRegular11.copyWith(
            color: AppColors.whiteDarker,
          ),
        ),
      ],
    );
  }

  // Widget _buildSuccessState(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Icon(
  //         Icons.check_circle_rounded,
  //         color: AppColors.greenNormal,
  //         size: 44.r,
  //       ),
  //       SizedBox(height: 8.h),
  //       Text(
  //         S.of(context).fileUploadedSuccessfully,
  //         style: TextStyles.cairoBold14.copyWith(
  //           color: AppColors.blueDarkActive,
  //         ),
  //       ),
        // SizedBox(height: 16.h),
        // CustomElevatedButton(
        //   text: S.of(context).reuploadFile,
        //   fun: onReuploadFile,
        //   height: 32.h,
        //   radius: CustomRadius.circle,
        //   withBorder: true,
        //   borderColor: AppColors.yellowDark,
        //   backgColor: AppColors.whiteLight,
        //   foregColor: AppColors.yellowDark,
        //   fontStyle: TextStyles.cairoBold12,
        //   prefixIcon: Icon(
        //     Icons.refresh_rounded,
        //     color: AppColors.yellowDark,
        //     size: 16.r,
        //   ),
        // ),
  //     ],
  //   );
  // }


}
