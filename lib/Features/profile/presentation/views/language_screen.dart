import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/providers/localization_provider.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/profile/presentation/widgets/language_selection_card.dart';
import 'package:motoverse/Features/profile/presentation/widgets/language_action_buttons.dart';
import 'package:motoverse/Features/profile/presentation/widgets/language_global_icon.dart';
import 'package:motoverse/Features/profile/presentation/widgets/language_notice_banner.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? tempSelectedLanguage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final languageProvider = Provider.of<LocalizationProvider>(
        context,
        listen: false,
      );
      setState(() {
        tempSelectedLanguage = languageProvider.local;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    );

    if (tempSelectedLanguage == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              Text(
                S.of(context).appLanguageTitle, 
                style: TextStyles.cairoBold24.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 12.h),

              const LanguageGlobalIcon(),
              SizedBox(height: 20.h),

              LanguageSelectionCard(
                langCode: 'ar',
                title: S
                    .of(context)
                    .arabicLanguage, 
                subtitle: 'Arabic',
                charBadge: 'ع',
                badgeBgColor: AppColors.yellowLightHover,
                badgeTextColor: AppColors.yellowDarkActive,
                isSelected: tempSelectedLanguage == 'ar',
                onTap: () => setState(() => tempSelectedLanguage = 'ar'),
              ),
              SizedBox(height: 16.h),

              LanguageSelectionCard(
                langCode: 'en',
                title: S
                    .of(context)
                    .englishLanguage, 
                subtitle: 'English',
                charBadge: 'EN',
                badgeBgColor: AppColors.blueLight,
                badgeTextColor: AppColors.blueNormal,
                isSelected: tempSelectedLanguage == 'en',
                onTap: () => setState(() => tempSelectedLanguage = 'en'),
              ),
              SizedBox(height: 24.h),

              const LanguageNoticeBanner(), 
              SizedBox(height: 40.h),

              LanguageActionButtons(
                onSave: () {
                  if (tempSelectedLanguage != languageProvider.local) {
                    languageProvider.setLang(tempSelectedLanguage!);
                  }
                  Navigator.pop(context);
                },
                onCancel: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
