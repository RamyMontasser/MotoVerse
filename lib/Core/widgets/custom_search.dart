import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    super.key,
    required this.hint,
    required this.search,
    this.onChanged,
    this.onSubmitted,
    this.suffix,
  });
  final String hint;
  final TextEditingController search;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: CustomRadius.auth,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(40),
            blurRadius: 2,
            spreadRadius: 0.5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: search,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        cursorColor: AppColors.blueNormal,
        style: TextStyles.cairoRegular16.copyWith(color: AppColors.blueDarker),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyles.cairoRegular14.copyWith(
            color: AppColors.whiteDarkActive,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SvgPicture.asset('assets/images/searchIcon.svg'),
          ),
          suffixIcon: suffix,
          filled: true,
          fillColor: AppColors.whiteNormal,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: CustomRadius.auth,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: CustomRadius.auth,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: CustomRadius.auth,
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
