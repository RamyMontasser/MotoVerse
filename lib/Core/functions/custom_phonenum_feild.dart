import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/auth/presentation/views/widgets/phone_textfeild.dart';
import 'package:motoverse/generated/l10n.dart';

class CustomPhonenumFeild extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  const CustomPhonenumFeild({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<CustomPhonenumFeild> createState() => _CustomPhonenumFeildState();
}

class _CustomPhonenumFeildState extends State<CustomPhonenumFeild> {
  Color textColor = AppColors.whiteDarker;
  CountryCode selectedCountryCode = CountryCode(code: 'EG', dialCode: '+20');
  String reversedCountryDial = '20+';
  String subString = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountryCodePicker(
          onChanged: (countryCode) {
            setState(() {
              selectedCountryCode = countryCode;
              if (selectedCountryCode.dialCode != null && selectedCountryCode.dialCode!.isNotEmpty) {
                subString = selectedCountryCode.dialCode!.substring(1);
                reversedCountryDial = '$subString+';
              }
            });
            widget.onChanged(countryCode.dialCode ?? '+20');
          },
          initialSelection: 'EG',
          favorite: const ['+20'],

          builder: (countryCode) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   countryCode!.dialCode!,
                //   style: TextStyles.cairoRegular16.copyWith(
                //     color: textColor,
                //     fontWeight: FontWeight.w600, // SemiBold
                //   ),
                // ),
                // SizedBox(width: 8.w),
                if (countryCode?.flagUri != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Image.asset(
                      countryCode!.flagUri!,
                      package: 'country_code_picker', // تحميل صور العلم
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.cover,
                    ),
                  ),

                SizedBox(width: 5.w),

                Icon(Icons.arrow_drop_down_rounded, size: 20.w),

                // SvgPicture.asset(
                //   'assets/images/Icon.svg',
                //   width: 12.w,
                //   height: 12.h,
                // ),
              ],
            );
          },

          boxDecoration: BoxDecoration(
            color: AppColors.whiteLight,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),

          headerText: S.of(context).selectCountry,

          dialogTextStyle: TextStyles.cairoRegular16.copyWith(color: textColor),

          searchStyle: TextStyles.cairoRegular16.copyWith(color: textColor),

          searchDecoration: InputDecoration(
            filled: true,
            fillColor: AppColors.blueLight,
            hintText: S.of(context).searchCountry,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
          ),
        ),

        SizedBox(width: 8.w),

        Expanded(
          child: PhoneTextFeild(
            countryCode: reversedCountryDial,
            phoneNume: widget.controller,
          ),
        ),
      ],
    );
  }
}
