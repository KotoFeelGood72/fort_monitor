import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  // Основной шрифт Jost
  static TextStyle get jost => GoogleFonts.jost();

  // Jost с разными весами
  static TextStyle get jostLight =>
      GoogleFonts.jost(fontWeight: FontWeight.w300);
  static TextStyle get jostRegular =>
      GoogleFonts.jost(fontWeight: FontWeight.w400);
  static TextStyle get jostMedium =>
      GoogleFonts.jost(fontWeight: FontWeight.w500);
  static TextStyle get jostSemiBold =>
      GoogleFonts.jost(fontWeight: FontWeight.w600);
  static TextStyle get jostBold =>
      GoogleFonts.jost(fontWeight: FontWeight.w700);

  // Jost с разными размерами
  static TextStyle jostSize(double size, {FontWeight? weight}) =>
      GoogleFonts.jost(fontSize: size, fontWeight: weight);

  // Готовые стили для разных элементов
  static TextStyle get heading1 =>
      GoogleFonts.jost(fontSize: 32, fontWeight: FontWeight.w700);

  static TextStyle get heading2 =>
      GoogleFonts.jost(fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle get heading3 =>
      GoogleFonts.jost(fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle get bodyLarge =>
      GoogleFonts.jost(fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle get bodyMedium =>
      GoogleFonts.jost(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle get bodySmall =>
      GoogleFonts.jost(fontSize: 12, fontWeight: FontWeight.w400);

  static TextStyle get button =>
      GoogleFonts.jost(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get caption =>
      GoogleFonts.jost(fontSize: 12, fontWeight: FontWeight.w400);
}
