import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/bot/presentation/widgets/ai_toggle_buttons.dart';
import 'package:motoverse/Features/bot/presentation/widgets/diagnosis_view.dart';
import 'package:motoverse/Features/bot/presentation/widgets/explain_problem_view.dart';
import 'package:motoverse/generated/l10n.dart';

class AiOptionsScreen extends StatefulWidget {
  const AiOptionsScreen({super.key});

  @override
  State<AiOptionsScreen> createState() => _AiOptionsScreenState();
}

class _AiOptionsScreenState extends State<AiOptionsScreen> {
  bool isExplainProblemSelected = true;
  final TextEditingController _problemController = TextEditingController();

  @override
  void dispose() {
    _problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Text(
                S.of(context).smartDiagnosis2,
                style: TextStyles.cairoBold24.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                S.of(context).chooseDiagnosisMethod,
                style: TextStyles.cairoRegular14.copyWith(
                  color: AppColors.whiteDarkHover,
                ),
              ),
              SizedBox(height: 30.h),
              AiToggleButtons(
                isExplainProblemSelected: isExplainProblemSelected,
                onToggleChanged: (value) {
                  setState(() {
                    isExplainProblemSelected = value;
                  });
                },
              ),
              SizedBox(height: 24.h),
              isExplainProblemSelected
                  ? ExplainProblemView(controller: _problemController)
                  : const DiagnosisView(),
              SizedBox(height: 90),
            ],
            
          ),
        ),
      ),
    );
  }
}
