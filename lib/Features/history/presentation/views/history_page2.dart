// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/theme/text_styles.dart';
// import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
// import 'package:motoverse/Features/history/presentation/widgets/bottom_sheet_button.dart';
// import 'package:motoverse/Features/history/presentation/widgets/center_info_card.dart';
// import 'package:motoverse/Features/history/presentation/widgets/cost_details_card.dart';
// import 'package:motoverse/Features/history/presentation/widgets/notes_card.dart';

// class HistoryPage2 extends StatelessWidget {
//   const HistoryPage2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           CustomScrollViewWithAppBar(
            
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const CenterInfoCard(),
          
//                       SizedBox(height: 20.h),
//                       Text(
//                         "اجمالي التكلفة",
//                         style: TextStyles.cairoBold16.copyWith(color: AppColors.blueNormal)
//                       ),
//                       SizedBox(height: 10.h),
          
//                       const CostDetailsCard(),
          
//                       SizedBox(height: 20.h),
//                       Text(
//                         "الملاحظات",
//                         style:  TextStyles.cairoBold16.copyWith(
//                           color: AppColors.blueNormal,
//                         )
//                       ),
//                       SizedBox(height: 10.h),
          
//                       const NotesCard(),
          
//                       SizedBox(height: 100.h),
//                     ],
//                   ),
//                 ),
//               ),
//               BottomSheetButton(
//             text: "تحميل الفاتورة (PDF)",
//             icon: Icons.file_download_outlined,
//           ),
//         ],
//       ),
//     );
//   }
// }









