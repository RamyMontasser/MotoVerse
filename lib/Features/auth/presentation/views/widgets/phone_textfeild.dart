import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

class PhoneTextFeild extends StatelessWidget {
  const PhoneTextFeild({
    super.key,
    required this.countryCode,
    required this.phoneNume,
  });
  final String countryCode;
  final TextEditingController phoneNume;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneNume,
      keyboardType: TextInputType.phone,
      style: TextStyles.cairoRegular14,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'برجاء إدخال الرقم';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteLight,
        suffixText: countryCode,
        hintText: S.of(context).enterPhoneNumber,
        hintStyle: TextStyles.cairoRegular14.copyWith(
          color: AppColors.whiteDarkHover,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(0, 0, 40.w, 20.h),
      ),
    );
  }
}
