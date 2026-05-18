import 'package:flutter/material.dart';
import 'package:motoverse/Core/errors/app_validator.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class CustomTextfeildWithBorder extends StatelessWidget {
  const CustomTextfeildWithBorder({
    super.key,
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.validator,
    this.isNumber = false,
  });

  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final String? Function(String?)? validator;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      cursorColor: AppColors.yellowNormal,
      validator: validator ?? AppValidator.validateEmpty,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: TextStyles.cairoRegular14.copyWith(color: AppColors.blueNormal),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyles.cairoRegular14.copyWith(
          color: AppColors.whiteDarkHover,
        ),
        filled: true,
        fillColor: AppColors.whiteLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: CustomRadius.card12,
          borderSide: const BorderSide(color: AppColors.blueLightHover),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: CustomRadius.card12,
          borderSide: const BorderSide(
            color: AppColors.blueNormalHover,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: CustomRadius.card12,
          borderSide: const BorderSide(color: AppColors.redNormal),
        ),
      ),
    );
  }
}
