import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/cache/app_pref.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/settings/presentation/widgets/settings_switch_tile.dart';
import 'package:motoverse/generated/l10n.dart';

class NotificaionSection extends StatefulWidget {
  const NotificaionSection({super.key});

  @override
  State<NotificaionSection> createState() => _NotificaionSectionState();
}

class _NotificaionSectionState extends State<NotificaionSection> {
  bool newCarsNoti = AppPref.getBool(key: 'newCarsNoti') ?? false;
  bool costChangeNoti = AppPref.getBool(key: 'costChangeNoti') ?? false;
  bool preperationNoti = AppPref.getBool(key: 'preperationNoti') ?? false;
  bool messageNoti = AppPref.getBool(key: 'messageNoti') ?? true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteLight,
      child: Column(
        children: [
          SizedBox(height: 10.h),

          SettingsSwitchTile(
            title: S.of(context).notifNewCars,
            iconPath: 'assets/images/notification.svg',
            desc: S.of(context).notifNewCarsDesc,
            switchValue: newCarsNoti,
            onSwitch: (bool value) {
              setState(() {
                newCarsNoti = value;
                AppPref.setBool(key: 'newCarsNoti', val: value);
              });
            },
          ),

          Divider(),

          SettingsSwitchTile(
            title: S.of(context).notifPriceChange,
            iconPath: 'assets/images/notification.svg',
            desc: S.of(context).notifPriceChangeDesc,
            switchValue: costChangeNoti,
            onSwitch: (bool value) {
              setState(() {
                costChangeNoti = value;
                AppPref.setBool(key: 'costChangeNoti', val: value);
              });
            },
          ),

          Divider(),

          SettingsSwitchTile(
            title: S.of(context).notifMaintenance,
            iconPath: 'assets/images/notification.svg',
            desc: S.of(context).notifMaintenanceDesc,
            switchValue: preperationNoti,
            onSwitch: (bool value) {
              setState(() {
                preperationNoti = value;
                AppPref.setBool(key: 'preperationNoti', val: value);
              });
            },
          ),

          Divider(),

          SettingsSwitchTile(
            title: S.of(context).notifMessages,
            iconPath: 'assets/images/notification.svg',
            desc: S.of(context).notifMessagesDesc,
            switchValue: messageNoti,
            onSwitch: (bool value) {
              setState(() {
                messageNoti = value;
                AppPref.setBool(key: 'messageNoti', val: value);
              });
            },
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
