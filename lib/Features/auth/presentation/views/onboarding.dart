import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/auth/presentation/views/widgets/onboarding_model.dart';
// import 'package:motoverse/generated/l10n.dart';
import 'package:percent_indicator/percent_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late List<OnboardingModel> pages;

  final PageController controller = PageController();

  int pageNum = 2;
  double progress = 1 / 3;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pages = [
      OnboardingModel(
        title: 'تشخيص ذكي وآمن\n حلل المشكلة بالذكاء الاصطناعي\n مع تجربة موثوقة ومحمية.',
        image: 'assets/images/onboarding/Frame1.svg',
        dx: -180,
        scale: 1.9,
      ),
      // OnboardingModel(
      //   title: S.of(context).onboarding2,
      //   image: 'assets/images/onboarding/Frame2.svg',
      //   dx: -100,
      //   scale: 1.35,
      // ),
      OnboardingModel(
        title: 'الوصول إلى مراكز صيانة معتمدة\n وأشخاص قادرين على المساعدة في محيطك.',
        image: 'assets/images/onboarding/Frame3.svg',
        dx: -60,
        scale: 1.25,
      ),
      OnboardingModel(
        title: 'تابع حالة سيارتك بشكل أوضح،\n وافهم الأعطال المحتملة قبل اتخاذ أي قرار.',
        image: 'assets/images/onboarding/Frame4.svg',
        dx: -50,
        scale: 1.6,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              SvgPicture.asset(
                'assets/images/logo1.svg',
                width: 120.w,
                height: 60.h,
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (val) {
                    setState(() {
                      pageNum = (val - 2) * (-1);
                      progress = (val + 1) / 3;
                    });
                  },
                  controller: controller,
                  reverse: true,
                  itemCount: pages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Text(
                            pages[index].title,
                            style: TextStyles.bold16Tajawal.copyWith(
                              color: AppColors.blueDarker,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: Center(
                            child: Transform.translate(
                              offset: Offset(pages[index].dx.w, 0),
                              child: Transform.scale(
                                scale: pages[index].scale,
                                child: SvgPicture.asset(
                                  pages[index].image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h, left: 15.w, right: 15.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70.w,
                      height: 70.w,
                      child: CircularPercentIndicator(animation: true,
                        radius: 32.w,
                        lineWidth: 4.w,
                        backgroundColor: AppColors.blueLightActive,
                        percent: progress,
                        center: IconButton(
                          onPressed: () {
                            if (controller.page == pages.length - 1) {
                              Navigator.of(context).popAndPushNamed('log in');
                            } else {
                              controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blueNormal,
                            fixedSize: Size(45.w, 45.w),
                            padding: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
                            shape: const CircleBorder(),
                          ),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 18.w,
                            color: AppColors.whiteLight,
                          ),
                        ),
                        progressColor: AppColors.blueNormal,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: List.generate(3, (index) {
                            final isActive = index == pageNum;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: isActive ? 24.w : 8.w,
                              height: 8.h,
                              margin: EdgeInsets.symmetric(horizontal: 3.w),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.blueNormal
                                    : AppColors.blueLightActive,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 13.h),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).popAndPushNamed('log in'),
                          child: Text(
                            'Skip',
                            style: TextStyles.reg20Tajawal.copyWith(
                              color: AppColors.blueNormalHover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// bool isEN() {
//   return Intl.getCurrentLocale() == 'en';
// }
