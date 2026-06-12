// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/theme/text_styles.dart';
// import 'package:motoverse/Features/bot/presentation/widgets/quick_option.dart';

// class ChatWelcome extends StatelessWidget {
//   const ChatWelcome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 70.h),

//         Text(
//           "كيف يمكننا مساعدتك اليوم ؟",
//           style: TextStyles.cairoBold24.copyWith(color: AppColors.blueNormal),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 15.h),
//         Text(
//           "اشرح المشكلة التي تواجهها في سيارتك \nوسنساعدك علي فهم السبب والخطوة التالية",
//           style: TextStyles.cairoRegular14.copyWith(
//             color: AppColors.whiteDarkActive,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 20.h),

//         QuickOption(
//           title: 'مشكلة في الفرامل',
//           iconPath: 'assets/icons/chats/ropot.svg',
//           fun: () {},
//         ),
//         SizedBox(height: 15.h),
//         QuickOption(
//           title: 'ضعف تبريد التكيف',
//           iconPath: 'assets/icons/chats/snow.svg',
//           fun: () {},
//         ),
//       ],
//     );
//   }
// }