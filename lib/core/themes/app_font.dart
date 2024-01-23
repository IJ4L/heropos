import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFont {
  AppFont._();

  static TextStyle normal = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.w100,
  );
  static TextStyle regular = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.w400,
  );
   static TextStyle popRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
  );
  static TextStyle semiBold = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.w600,
  );
  static TextStyle popSemiBold = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
  );
  static TextStyle bold = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.bold,
  );
}

extension AppFontSize on TextStyle {
  TextStyle get s10 {
    return copyWith(fontSize: 10.sp);
  }

  TextStyle get s12 {
    return copyWith(fontSize: 12.sp);
  }

  TextStyle get s14 {
    return copyWith(fontSize: 14.sp);
  }

  TextStyle get s16 {
    return copyWith(fontSize: 16.sp);
  }

  TextStyle get s20 {
    return copyWith(fontSize: 20.sp);
  }
}
