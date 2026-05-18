// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:motoverse/Core/theme/app_colors.dart';

// PreferredSizeWidget myAppBar({Widget? actionicon, VoidCallback? action}) {
//   return AppBar(
//     bottom: PreferredSize(
//       preferredSize: Size(double.infinity, 15.h),
//       child: Container(),
//     ),
//     centerTitle: true,
//     title: SvgPicture.asset(
//       'assets/images/motoverse.svg',
//       width: 135.w,
//       height: 22.h,
//     ),
//     actions: [
//       IconButton(
//         onPressed: action ?? () {},
//         icon:
//             actionicon ??
//             SvgPicture.asset(
//               'assets/images/notification.svg',
//               width: 24.w,
//               height: 24.h,
//             ),
//       ),
//     ],
//     flexibleSpace: Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             AppColors.redGradianDark,
//             AppColors.blueNormal,
//             AppColors.blueNormal,
//           ],
//         ),
//       ),
//     ),
//   );
// }
