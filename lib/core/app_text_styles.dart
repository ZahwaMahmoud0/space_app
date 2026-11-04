import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class AppText {
  
  static TextStyle get heading => GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 36 / 24,
        letterSpacing: 24 * -0.03,
        color: kWhite,
      );


  static TextStyle get bodyLight => GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        height: 22 / 16,
        letterSpacing: 0,
        color: kWhite,
      );

 
  static TextStyle get stat => GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 36 / 16,
        letterSpacing: 16 * -0.03,
        color: kWhite,
      );
}