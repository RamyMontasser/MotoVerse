import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/services/image_picker_service.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/settings/data/models/identity_feild_model.dart';
import 'package:motoverse/generated/l10n.dart';

class IdentityPickerCard extends StatelessWidget {
  const IdentityPickerCard({
    super.key,
    required this.field,
    this.pickedImage,
    required this.onCardTap,
  });

  final IdentityFieldModel field;
  final XFile? pickedImage;
  final Function(XFile) onCardTap;

  @override
  Widget build(BuildContext context) {
    final ImagePickerService imageService = getIt<ImagePickerService>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GestureDetector(
        onTap: () async {
          final response = await imageService.pickImage(
            source: ImageSource.camera,
          );
          if (response != null) {
            onCardTap(response);
          }
        },
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            padding: EdgeInsets.zero,
            color: AppColors.blueLightHover,
            dashPattern: const [7, 4],
            strokeWidth: 3.w,
            borderPadding: EdgeInsets.zero,
            radius: Radius.circular(13.r),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: pickedImage != null ? 26.h : 60.h,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteLight,
              borderRadius: CustomRadius.card12,
              boxShadow: [
                BoxShadow(
                  color: AppColors.blueDarker.withAlpha(40),
                  blurRadius: 8,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: (pickedImage != null)
                ? _buildSuccessState(
                    context,
                  ) 
                : _buildInitialState(),
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(field.iconPath, color: AppColors.blueLightActive),
        SizedBox(height: 5.h),
        Text(
          field.title,
          style: TextStyles.cairoBold13.copyWith(
            color: AppColors.blueLightActive,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    final ImagePickerService imageService = getIt<ImagePickerService>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: AppColors.greenNormal,
          size: 38.sp,
        ),
        SizedBox(height: 5.h),
        Text(
          S.of(context).uploadSuccess, 
          style: TextStyles.cairoBold12.copyWith(
            color: AppColors.blueLightActive,
          ),
        ),
        SizedBox(height: 20.h),

        CustomElevatedButton(
          text: S.of(context).reupload, 
          fun: () async {
            final response = await imageService.pickImage(
              source: ImageSource.camera,
            );
            if (response != null) {
              onCardTap(response);
            }
          },
          height: 24,
          radius: CustomRadius.circle,
          withBorder: true,
          borderColor: AppColors.blueNormal,
          backgColor: AppColors.whiteLight,
          foregColor: AppColors.blueNormal,
          fontStyle: TextStyles.cairoBold12,
          prefixIcon: const Icon(
            Icons.file_upload_outlined,
            color: AppColors.blueNormal,
          ),
        ),
      ],
    );
  }
}
