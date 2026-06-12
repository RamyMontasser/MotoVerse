import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';

class ExplainProblemView extends StatelessWidget {
  final TextEditingController controller;

  const ExplainProblemView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.blueGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.edit_note_rounded,
                color: AppColors.yellowNormal,
                size: 28.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'التشخيص الذكي بالذكاء الاصطناعي',
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'تحليل مشكلات السيارة من خلال وصف الأعراض وتقديم اقتراحات وتشخيصات ذكية.',
            style: TextStyles.cairoRegular13.copyWith(
              color: AppColors.whiteDarkHover,
            ),
          ),
          SizedBox(height: 20.h),
          TextField(
            controller: controller,
            maxLines: 6,
            style: TextStyles.cairoRegular14.copyWith(
              color: AppColors.blueDark,
            ),
            decoration: InputDecoration(
              hintText:
                  'مثال: يوجد صوت غريب عند الفرامل في العجلات الأمامية...',
              hintStyle: TextStyles.cairoRegular13.copyWith(
                color: AppColors.whiteDark,
              ),
              fillColor: AppColors.whiteNormal,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.whiteNormal,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.whiteDarkHover,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'التشخيص استرشادي وليس بديلاً عن الفحص الفني.',
                    style: TextStyles.cairoRegular11.copyWith(
                      color: AppColors.whiteDarker,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            text: 'تحليل المشكلة',
            radius: BorderRadius.circular(16.r),
            height: 48,
            fontStyle: TextStyles.cairoBold16,
            fun: () {
              final text = controller.text.trim();
              if (text.isEmpty) {
                customSnackBar(
                  context: context,
                  msg: 'يرجى كتابة وصف للمشكلة أولاً قبل التحليل.',
                  isDone: false,
                );
              } else {
                Navigator.of(context).pushNamed('AiAssistant', arguments: text);
              }
            },
          ),
        ],
      ),
    );
  }
}
