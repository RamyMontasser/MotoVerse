import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/settings/presentation/widgets/settings_tile.dart';
import 'package:motoverse/generated/l10n.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteLight,
      child: Column(
        children: [
          SizedBox(height: 10.h),

          SettingsTile(
            title: S.of(context).privacyPolicy,
            iconPath: 'assets/images/settings_documment.svg',
            desc: S.of(context).privacyPolicyDesc,
            fun: () {},
          ),

          Divider(),

          SettingsTile(
            title: S.of(context).termsOfUse,
            iconPath: 'assets/images/settings_security.svg',
            desc: S.of(context).termsOfUseDesc,
            fun: () {},
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
