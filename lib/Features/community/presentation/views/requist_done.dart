// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:motoverse/Core/providers/navigation_provider.dart';
// import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/theme/custom_radius.dart';
// import 'package:motoverse/Core/theme/text_styles.dart';
// import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
// import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
// import 'package:motoverse/Features/community/presentation/widgets/map_card.dart';

// class RequestDone extends StatelessWidget {
//   const RequestDone({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollViewWithAppBar(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//                 decoration: BoxDecoration(
//                   color: AppColors.greenLight,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Icon(
//                     Icons.check_circle_outline,
//                     color: AppColors.greenNormal,
//                     size: 65.sp,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               Text(
//                 'تم ارسال الطلب بنجاح',
//                 style: TextStyles.cairoBold24.copyWith(
//                   color: AppColors.blueNormal,
//                 ),
//               ),
//               SizedBox(height: 6.h),
//               Text(
//                 'تم استلام طلبك بنجاح وسيتم عرض في سجل الطلبات',
//                 style: TextStyles.cairoRegular14.copyWith(
//                   color: AppColors.whiteDarkActive,
//                 ),
//               ),
//               SizedBox(height: 20.h),

//               MapCard(isDone: true),

//               SizedBox(height: 30.h),

//               CustomElevatedButton(
//                 text: 'تتبع الطلب',
//                 radius: CustomRadius.card12,
//                 fun: () {},
//                 height: 56,
//                 fontStyle: TextStyles.cairoBold16,
//                 backgColor: AppColors.yellowNormal,
//                 prefixIcon: Icon(Icons.map_outlined, size: 20.sp),
//               ),

//               SizedBox(height: 15.h),

//               CustomElevatedButton(
//                 text: 'العودة للصفحة الرئيسية',
//                 radius: CustomRadius.card12,
//                 fun: () {
//                   context.read<NavigationProvider>().changeIndex(0);
//                   Navigator.of(context).pushNamedAndRemoveUntil('main screen', (route) => false);
//                 },
//                 height: 48,
//                 fontStyle: TextStyles.cairoBold16,
//                 foregColor: AppColors.blueNormal,
//                 backgColor: AppColors.blueLightHover,
//                 prefixIcon: Icon(
//                   Icons.home_filled,
//                   size: 20.sp,
//                   color: AppColors.blueNormal,
//                 ),
//               ),

//               SizedBox(height: 50.h),

//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
//                 decoration: BoxDecoration(
//                   color: AppColors.blueLight,
//                   borderRadius: CustomRadius.r1,
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.shield_outlined,
//                       size: 24.sp,
//                       color: AppColors.blueNormal,
//                     ),
//                     SizedBox(width: 8.w),
//                     Expanded(
//                       child: Text(
//                         'طلبك مؤمن ومدعوم بضمان Motoverse Safety.',
//                         style: TextStyles.cairoRegular14.copyWith(
//                           color: AppColors.blueNormal,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
