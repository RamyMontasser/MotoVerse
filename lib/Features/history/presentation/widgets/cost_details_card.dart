// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/theme/custom_radius.dart';
// import 'package:motoverse/Core/theme/text_styles.dart';

// class CostDetailsCard extends StatelessWidget {
//   const CostDetailsCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: AppColors.whiteLight,
//         borderRadius: CustomRadius.card12,
//         border: Border.all(color: AppColors.blueLight),
//       ),
//       child: Column(
//         children: [
//           // _buildCostRow("تيل فرامل سيراميك (أمامي)", "\$120.00"),
//           // _buildCostRow("مصنعية / شغل يد (ساعة ونصف)", "\$110.00"),
//           // _buildCostRow("ضرائب ورسوم", "\$15.00"),
//           // const Divider(color: AppColors.blueLight),
//           _buildCostRow("إجمالي التكلفة", "\$245.00", isTotal: true),
//         ],
//       ),
//     );
//   }

//   Widget _buildCostRow(String title, String price, {bool isTotal = false}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: isTotal
//                 ? TextStyles.bold16Tajawal.copyWith(
//                     color: AppColors.blueNormalActive,
//                   )
//                 : TextStyles.med13Tajawal.copyWith(color: AppColors.black),
//           ),

//           Text(
//             price,
//             style: isTotal
//                 ? TextStyles.med16Tajawal.copyWith(
//                     color: AppColors.blueNormalActive,
//                   )
//                 : TextStyles.med13Tajawal.copyWith(
//                     color: AppColors.blueNormalHover,
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
