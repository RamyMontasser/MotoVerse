// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/theme/custom_radius.dart';
// import 'package:motoverse/Core/theme/text_styles.dart';

// class ProfileTile extends StatelessWidget {
//   const ProfileTile({super.key, required this.name, required this.email});

//   final String name;
//   final String email;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 91.h,
//       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//       margin: EdgeInsets.symmetric(vertical: 15.h),
//       decoration: BoxDecoration(
//         borderRadius: CustomRadius.card,
//         color: AppColors.whiteLightHover,
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.black.withAlpha(40),
//             blurRadius: 3,
//             spreadRadius: 1.5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 72.w,
//             height: 90.h,
//             // margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50.r),
//               color: AppColors.whiteLight,
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.black.withAlpha(35),
//                   blurRadius: 6,
//                   // spreadRadius: 1,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 name.isNotEmpty ? name[0] : '',
//                 style: TextStyles.cairoMedium16.copyWith(
//                   color: AppColors.blueDarker,
//                 ),
//               ),
//             ),
//           ),

//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyles.cairoMedium16.copyWith(
//                     color: AppColors.blueDarker,
//                   ),
//                 ),
//                 Text(
//                   email,
//                   // textDirection: TextDirection.ltr,
//                   style: TextStyles.cairoRegular14.copyWith(
//                     color: AppColors.blueNormalActive,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
