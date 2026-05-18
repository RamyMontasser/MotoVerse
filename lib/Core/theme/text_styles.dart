import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyles {
  // Line Height is 150% (1.5) and Letter Spacing is 0% (0.0) for all styles
  // static  double _lineHeight = 1.5;
  static const double _letterSpacing = 0.0; // 0%

  // --- Cairo Font Styles ---

  static TextStyle cairoBold62 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold,
    fontSize: 62.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoBold47 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold,
    fontSize: 47.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoBold32 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold,
    fontSize: 32.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );
  
  static TextStyle cairoBold24 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoBold20 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold,
    fontSize: 20.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );
  
  static TextStyle cairoBold16 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoSemiBold24 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 24.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );
  
  static TextStyle cairoBold14 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold, // Bold
    fontSize: 14.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoBold13 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold, // Bold
    fontSize: 13.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoBold12 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold, // Bold
    fontSize: 12.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoMedium20 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w500, // Medium
    fontSize: 20.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoMedium12 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w500, // Medium
    fontSize: 12.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoMedium16 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w500, // Medium
    fontSize: 16.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoRegular18 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 18.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoRegular16 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 16.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoSemiBold18 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 18.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );
  
  static TextStyle cairoBold18 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.bold, // Bold
    fontSize: 18.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoSemiBold20 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 20.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoSemiBold16 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 16.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoRegular14 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 14.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle cairoRegular11 = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 11.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  // --- Tajawal Font Styles (Regular) ---

  static TextStyle reg10Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 10.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle reg12Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 12.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle reg16Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 16.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle reg20Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 20.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle reg24Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 24.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  // --- Tajawal Font Styles (Medium) ---

  static TextStyle med13Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500, // Medium
    fontSize: 13.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle med16Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500, // Medium
    fontSize: 16.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle med20Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500, // Medium
    fontSize: 20.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle med24Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500, // Medium
    fontSize: 24.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle med32Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500, // Medium
    fontSize: 32.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  // --- Tajawal Font Styles (Bold) ---

  static TextStyle bold16Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold, // Bold
    fontSize: 16.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle bold11Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold, // Bold
    fontSize: 11.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle bold24Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold, // Bold
    fontSize: 23.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );

  static TextStyle bold32Tajawal = TextStyle(
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold, // Bold
    fontSize: 32.sp,
    // height: _lineHeight,
    letterSpacing: _letterSpacing,
  );
}
