import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/community/data/models/problem_type_model.dart';
import 'package:motoverse/generated/l10n.dart';

class CarInfoCard extends StatelessWidget {
  final String problemType;
  CarInfoCard({super.key, required this.problemType});

  final List<ProblemTypeModel> _problemTypes = [
    ProblemTypeModel(
      title: "battery",
      titleEnglish: "battery",
      iconPath: 'assets/icons/community/battery.svg',
    ),
    ProblemTypeModel(
      title: "engine",
      titleEnglish: "engine",
      iconPath: 'assets/icons/community/motor.svg',
    ),
    ProblemTypeModel(
      title: "tires",
      titleEnglish: "tires",
      iconPath: 'assets/icons/community/wheels.svg',
    ),
    ProblemTypeModel(
      title: "other",
      titleEnglish: "other",
      iconPath: 'assets/icons/community/other.svg',
    ),
  ];

  String getLocalizedProblemTitle(
    BuildContext context,
    String englishTypeFromBackend,
  ) {
    try {
      final matchedProblem = _problemTypes.firstWhere(
        (problem) => problem.titleEnglish == englishTypeFromBackend,
      );

      switch (matchedProblem.titleEnglish) {
        case 'battery':
          return S.of(context).battery;
        case 'engine':
          return S.of(context).engine;
        case 'tires':
          return S.of(context).tires;
        default:
          return S.of(context).other;
      }
    } catch (_) {
      return S.of(context).other;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: CustomRadius.r20,
        border: Border.all(color: AppColors.blueLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S.of(context).car,
                      style: TextStyles.cairoMedium12.copyWith(
                        color: AppColors.whiteDarker,
                      ),
                    ),
                    Text(
                      'تويوتا كامري 2022',
                      style: TextStyles.cairoBold16.copyWith(
                        color: AppColors.blueNormal,
                        height: 2.h,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.blueGrey,
                  borderRadius: CustomRadius.r1,
                ),
                child: Icon(
                  Icons.car_crash_outlined,
                  size: 28.sp,
                  color: AppColors.yellowNormal,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.redLight,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.redNormal.withAlpha(30)),
            ),
            child: Row(
              children: [
                const Icon(Icons.error, color: AppColors.redNormal),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).reportedProblem,
                        style: TextStyles.cairoRegular11.copyWith(
                          color: AppColors.redNormal,
                        ),
                      ),
                      Text(
                        S
                            .of(context)
                            .malfunctionIn(
                              getLocalizedProblemTitle(context, problemType),
                            ),
                        style: TextStyles.cairoBold16.copyWith(
                          color: AppColors.blueDarkActive,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isEN() {
    return Intl.getCurrentLocale() == 'en';
  }
}
