import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/bot/presentation/widgets/message.dart';

class ChatResponse extends StatelessWidget {
  const ChatResponse({
    super.key,
    required this.userMessage,
    this.code, 
    this.description,
    required this.problemSummary,
    required this.severityLevel,
    required this.canDrive,
    required this.possibleCauses,
    required this.whatToCheck,
    required this.canCheckAtHome,
    required this.recommendation,
  });

  final String userMessage;
  final String? code;
  final String? description;
  final String problemSummary;
  final String severityLevel;
  final String canDrive;
  final List<String> possibleCauses;
  final List<String> whatToCheck;
  final bool canCheckAtHome;
  final String recommendation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (userMessage.isNotEmpty) ...[
          Message(messageContent: userMessage),
          SizedBox(height: 24.h),
        ],
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.blueGrey,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.blueGrey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (code != null && code!.isNotEmpty) ...[
                Text(
                  code!,
                  style: TextStyles.cairoBold20.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),
                if (description != null && description!.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    description!,
                    style: TextStyles.cairoMedium12.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                ],
                Divider(
                  color: AppColors.blueLightHover,
                  height: 24.h,
                ),
              ],

              Text(
                'ملخص التشخيص:',
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.yellowNormal,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                problemSummary,
                style: TextStyles.cairoMedium14.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                'مستوى الخطورة: ',
                style: TextStyles.cairoBold14.copyWith(
                  color: AppColors.redNormal,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                severityLevel,
                style: TextStyles.cairoMedium14.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                'هل بإمكانك القيادة: ',
                style: TextStyles.cairoBold14.copyWith(
                  color: AppColors.redNormal,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                canDrive,
                style: TextStyles.cairoMedium14.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 16.h),

              if (possibleCauses.isNotEmpty) ...[
                Text(
                  'الاسباب المحتملة: ',
                  style: TextStyles.cairoBold16.copyWith(
                    color: AppColors.yellowNormal,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  possibleCauses.join('\n\n'),
                  style: TextStyles.cairoMedium14.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),
                SizedBox(height: 16.h),
              ],

              if (whatToCheck.isNotEmpty) ...[
                Text(
                  'ما يجب فحصه: ',
                  style: TextStyles.cairoBold16.copyWith(
                    color: AppColors.yellowNormal,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  whatToCheck.join('\n\n'),
                  style: TextStyles.cairoMedium14.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),
                SizedBox(height: 12.h),
              ],

              Text(
                'هل يمكنك فحص المشكلة في المنزل؟ ',
                style: TextStyles.cairoBold14.copyWith(
                  color: AppColors.greenNormal,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                canCheckAtHome ? 'نعم' : 'لا',
                style: TextStyles.cairoMedium14.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                'التوصية الفنية: ',
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.yellowNormal,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                recommendation,
                style: TextStyles.cairoMedium14.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
