// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/theme/custom_radius.dart';
// import 'package:motoverse/Core/theme/text_styles.dart';

// class SettingsSwitchTile extends StatelessWidget {
//   const SettingsSwitchTile({
//     super.key,
//     required this.title,
//     required this.iconPath,
//     required this.desc,
//     required this.switchValue,
//     required this.onSwitch,
//   });

//   final String title;
//   final String desc;
//   final String iconPath;
//   final bool switchValue;
//   final ValueChanged<bool>? onSwitch;

//   @override
//   Widget build(BuildContext context) {
//     return
//     // Container(
//     //   height: 98.h,
//     //   padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//     //   margin: EdgeInsets.symmetric(vertical: 5.h),
//     //   decoration: BoxDecoration(
//     //     borderRadius: CustomRadius.card,
//     //     color: AppColors.whiteLight,
//     //     boxShadow: [
//     //       BoxShadow(
//     //         color: AppColors.black.withAlpha(50),
//     //         blurRadius: 3,
//     //         spreadRadius: 1,
//     //         offset: const Offset(0, 2),
//     //       ),
//     //     ],
//     //   ),
//     // Row(
//     //   children: [
//     // Container(
//     //   width: 40.w,
//     //   height: 40.h,
//     //   decoration: BoxDecoration(
//     //     borderRadius: CustomRadius.card,
//     //     color: AppColors.blueLightHover,
//     //   ),
//     //   child: Center(child: SvgPicture.asset(iconPath,color: AppColors.blueNormal ,)),
//     // ),
//     //     Padding(
//     //       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
//     //       child: Column(
//     //         crossAxisAlignment: CrossAxisAlignment.start,
//     //         children: [
//     //           Text(title, style: TextStyles.cairoSemiBold16),
//     //           Text(desc, style: TextStyles.cairoRegular14),
//     //         ],
//     //       ),
//     //     ),
//     //     Spacer(),
//     // Switch(
//     //   value: switchValue,
//     //   onChanged: onSwitch,
//     //   activeTrackColor: AppColors.blueNormal,
//     //   inactiveTrackColor: AppColors.whiteNormal,
//     //   inactiveThumbColor: AppColors.whiteLight,
//     //   trackOutlineWidth: WidgetStateProperty.all(0),
//     //   trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
//     //   ),
//     //   ],
//     // );
//     ListTile(
//       contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
//       leading: Container(
//         width: 40.w,
//         height: 40.h,
//         decoration: BoxDecoration(
//           borderRadius: CustomRadius.card,
//           color: AppColors.blueLightHover,
//         ),
//         child: Center(
//           child: SvgPicture.asset(iconPath, color: AppColors.blueNormal),
//         ),
//       ),
//       title: Text(title, style: TextStyles.cairoSemiBold16),

//       subtitle: Text(desc, style: TextStyles.cairoRegular14),

//       trailing: Transform.scale(
//         scale: 0.85,
//         child: Switch(
//           value: switchValue,
//           onChanged: onSwitch,
//           activeTrackColor: AppColors.blueNormal,
//           inactiveTrackColor: AppColors.whiteNormal,
//           inactiveThumbColor: AppColors.whiteLight,
//           trackOutlineWidth: WidgetStateProperty.all(0),
//           trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
//         ),
//       ),
//     );
//   }
// }
