import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/providers/localization_provider.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:provider/provider.dart';

class ChangeLangSection extends StatefulWidget {
  const ChangeLangSection({super.key});

  @override
  State<ChangeLangSection> createState() => _ChangeLangSectionState();
}

class _ChangeLangSectionState extends State<ChangeLangSection> {
  @override
  Widget build(BuildContext context) {
    // return Consumer<LocalizationProvider>(
    //   builder: (context, localizationProvider, child) {
    // String selectedLang = localizationProvider.getLang() == 'ar'
    //     ? 'العربية'
    //     : 'English';
    // String unSelectedLang = selectedLang == 'English'
    //     ? 'العربية'
    //     : 'English';

    var provider = Provider.of<LocalizationProvider>(context, listen: true);

    bool isArabic = provider.local == 'ar';
    String selectedLang = isArabic ? 'العربية' : 'English';
    String unSelectedLang = isArabic ? 'English' : 'العربية';
    return Card(
      color: AppColors.whiteLight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: CustomRadius.card,
                color: AppColors.blueLightHover,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/settings_world.svg',
                  color: AppColors.blueNormal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).language,
                    style: TextStyles.cairoSemiBold16,
                  ),
                  SizedBox(height: 10.h),

                  Container(
                    width: 250.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      borderRadius: CustomRadius.r1,
                      color: AppColors.blueLightHover,
                    ),
                    child: Center(
                      child: Text(
                        selectedLang,
                        style: TextStyles.cairoRegular16,
                      ),
                    ),
                  ),

                  SizedBox(height: 5.h),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLang = unSelectedLang;
                        if (isArabic) {
                          provider.setLang('en'); // لو عربي حول إنجليزي
                        } else {
                          provider.setLang('ar'); // لو إنجليزي حول عربي
                        }
                        // provider.setLang(unSelectedLang);
                        // localizationProvider.setLang(unSelectedLang);
                        // AppPref.setString(
                        //   key: 'selectedLang',
                        //   val: unSelectedLang,
                        // );
                      });
                    },
                    child: Container(
                      width: 250.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: CustomRadius.r1,
                        color: AppColors.whiteLightActive,
                      ),
                      child: Center(
                        child: Text(
                          unSelectedLang,
                          style: TextStyles.cairoRegular16,
                        ),
                      ),
                    ),
                  ),
                  // Text(desc, style: TextStyles.cairoRegular14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //   },
    // );
    //
    //
    //
    //
    // ListTile(
    //   contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
    //   leading: Container(
    //     width: 40.w,
    //     height: 40.h,
    //     decoration: BoxDecoration(
    //       borderRadius: CustomRadius.card,
    //       color: AppColors.blueLightHover,
    //     ),
    //     child: Center(
    //       child: SvgPicture.asset(iconPath, color: AppColors.blueNormal),
    //     ),
    //   ),
    //   title: Text(title, style: TextStyles.cairoSemiBold16),

    //   subtitle: Text(desc, style: TextStyles.cairoRegular14),

    //   trailing: Transform.scale(
    //     scale: 0.85,
    //     child: Switch(
    //       value: switchValue,
    //       onChanged: onSwitch,
    //       activeTrackColor: AppColors.blueNormal,
    //       inactiveTrackColor: AppColors.whiteNormal,
    //       inactiveThumbColor: AppColors.whiteLight,
    //       trackOutlineWidth: WidgetStateProperty.all(0),
    //       trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    //     ),
    //   ),
    // );
  }
}
