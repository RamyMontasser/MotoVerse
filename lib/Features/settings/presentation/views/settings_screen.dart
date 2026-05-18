import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/theme/button_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
// import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_sec_sliver_appbar.dart';
import 'package:motoverse/Features/settings/presentation/section/change_lang_section.dart';
import 'package:motoverse/Features/settings/presentation/section/notificaion_section.dart';
import 'package:motoverse/Features/settings/presentation/section/security_section.dart';
import 'package:motoverse/Features/settings/presentation/widgets/settings_tile.dart';
import 'package:motoverse/Features/settings/presentation/widgets/version_column.dart';
import 'package:motoverse/generated/l10n.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSecSliverAppbar(title: S.of(context).settings),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).personalSettings,
                    style: TextStyles.cairoMedium16.copyWith(
                      color: AppColors.whiteDarker,
                    ),
                  ),
                  Card(
                    color: AppColors.whiteLight,
                    child: SettingsTile(
                      title: S.of(context).editProfile,
                      iconPath: 'assets/images/profile_person.svg',
                      desc: S.of(context).updateInfo,
                      fun: () {},
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    S.of(context).notifications,
                    style: TextStyles.cairoMedium16.copyWith(
                      color: AppColors.whiteDarker,
                    ),
                  ),
                  NotificaionSection(),

                  SizedBox(height: 20.h),

                  Text(
                    S.of(context).appLanguage,
                    style: TextStyles.cairoMedium16.copyWith(
                      color: AppColors.whiteDarker,
                    ),
                  ),
                  ChangeLangSection(),

                  SizedBox(height: 20.h),

                  Text(
                    S.of(context).privacySecurity,
                    style: TextStyles.cairoMedium16.copyWith(
                      color: AppColors.whiteDarker,
                    ),
                  ),
                  SecuritySection(),

                  SizedBox(height: 20.h),

                  // CustomElevatedButton(
                  //   text: S.of(context).deleteAccount,
                  //   radius: CustomRadius.card,
                  //   fun: () {},
                  //   withBorder: true,
                  //   backgColor: AppColors.whiteLight,
                  //   foregColor: AppColors.blueNormal,
                  //   prefixIconPath: 'assets/images/trash.svg',
                  // ),
                  SizedBox(height: 30.h),

                  VersionColumn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
