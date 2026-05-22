import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/generated/l10n.dart';

class GreatingCard extends StatelessWidget {
  const GreatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.blueNormal,
      elevation: 9,
      shadowColor: AppColors.blueDark.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  width: 90.w,
                  height: 23.h,
                  decoration: BoxDecoration(
                    borderRadius: CustomRadius.r3,
                    color: AppColors.yellowNormal,
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).newAdvantage,
                      style: TextStyles.cairoBold12.copyWith(
                        color: AppColors.whiteLight,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: SvgPicture.asset('assets/icons/home/Stars.svg'),
                ),
              ],
            ),
            SizedBox(height: 5.h),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Text(
                        S.of(context).smartDiagnosis,
                        style: TextStyles.cairoBold20.copyWith(
                          color: AppColors.whiteLight,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        S.of(context).smartDiagnosisSubtitle,
                        style: TextStyles.cairoRegular14.copyWith(
                          color: AppColors.blueLightActive,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: SvgPicture.asset(
                    'assets/icons/home/home_prepare.svg',
                    height: 90,
                    colorFilter: ColorFilter.mode(
                      AppColors.whiteLight.withValues(alpha: 0.2),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            CustomElevatedButton(
              text: S.of(context).startDiagnosis,
              radius: CustomRadius.r1,
              width: double.infinity,
              height: 40,
              backgColor: AppColors.whiteLight,
              foregColor: AppColors.blueNormal,
              fontStyle: TextStyles.cairoBold16,
              suffixIconPath: 'assets/images/Arrow-right-2.svg',
              fun: () {
                context.read<NavigationProvider>().changeIndex(1);
              },
              withBorder: false,
            ),
          ],
        ),
      ),
    );
  }
}
