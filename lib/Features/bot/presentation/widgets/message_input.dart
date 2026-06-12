// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:motoverse/Core/errors/app_validator.dart';
// import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/theme/custom_radius.dart';
// import 'package:motoverse/Core/theme/text_styles.dart';

// class MessageInput extends StatelessWidget {
//   const MessageInput({super.key, required this.message, required this.onSend, required this.isAI});
//   final TextEditingController message;
//   final VoidCallback onSend;
//   final bool isAI;

//   @override
//   Widget build(BuildContext context) {
//     // final _formKey = GlobalKey<FormState>();
//     return Container(
//       color: AppColors.whiteLight,
//       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ...(isAI? [
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 10.h),
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//             decoration: BoxDecoration(
//               color: AppColors.whiteNormal,
//               borderRadius: CustomRadius.r2,
//             ),
//             child:
//             Row(
//               children: [
//                 Icon(
//                   Icons.info_outline,
//                   size: 16.sp,
//                   color: AppColors.blueLightActive,
//                 ),
//                 SizedBox(width: 5.w),
//                 Expanded(
//                   child: Text(
//                     "التشخيص هو مؤشر وليس بديلاً عن الفحص الفني.",
//                     style: TextStyles.cairoRegular11.copyWith(
//                       color: AppColors.blueLightActive,
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ),
              
//           SizedBox(height: 10.h),
//           ]: []),
//           Row(
//             children: [
//               // Container(
//               //   padding: EdgeInsets.all(12.w),
//               //   decoration: const BoxDecoration(
//               //     color: Colors.orange,
//               //     shape: BoxShape.circle,
//               //   ),
//               //   child: Transform.rotate(
//               //     angle: 3.14,
//               //     child: const Icon(Icons.send, color: Colors.white),
//               //   ),
//               // ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteNormal,
//                     borderRadius: BorderRadius.circular(30.r),
//                     border: Border.all(color: Colors.black12),
//                   ),
//                   child: 
//                     TextFormField(
//                      controller: message,
//                      cursorColor: AppColors.yellowNormal,
//                      style: TextStyles.cairoRegular16.copyWith(
//                        color: AppColors.black,
//                      ),
//                      // validator: (value) => AppValidator.validateEmpty(value),
//                      // textAlign: TextAlign.right,
//                      decoration: InputDecoration(
//                        // prefixIcon: Icon(
//                        //   Icons.mic_none_outlined,
//                        //   color: AppColors.whiteDark,
//                        //   size: 24.sp,
//                        // ),
//                        hintText:isAI? "اكتب مشكلتك هنا": null,
//                        hintStyle: TextStyles.cairoRegular14.copyWith(
//                          color: AppColors.whiteDark,
//                        ),
//                        border: InputBorder.none,
//                        contentPadding: EdgeInsets.symmetric(
//                          vertical: 12.h,
//                          horizontal: 10.w,
//                        ),
//                      ),
//                                       ),
//                 ),
//               ),
//               SizedBox(width: 10.w),
//               IconButton(
//                 padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
//                 style: IconButton.styleFrom(
//                   elevation: 6, 
//                   shadowColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: CustomRadius.circle,
//                   ),

//                   backgroundColor: AppColors.yellowNormal,
//                 ),
//                 onPressed:(){
//                   if(message.text.isNotEmpty){
//                     onSend();
//                   }
//                 },
//                 icon: Icon(Icons.send_rounded, color: AppColors.whiteLight),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
