import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  static TextStyle heading1 = GoogleFonts.gloock(
    textStyle: TextStyle(
      fontSize: 64.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
  );

  static TextStyle bodyText = GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black54,
    ),
  );

  static TextStyle subtitle = GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18.sp,
      fontStyle: FontStyle.italic,
      color: Colors.black87,
    ),
  );

  static TextStyle caption = GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black45,
    ),
  );
}
