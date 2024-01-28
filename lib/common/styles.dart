

import 'package:flutter/material.dart';

const TextTheme customTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 18, fontFamily: "Lato", fontWeight: FontWeight.w900, color: CustomColor.textBlack),
  displayMedium: TextStyle(fontSize: 16, fontFamily: "Lato", fontWeight: FontWeight.w500, color: CustomColor.textBlack),
  displaySmall: TextStyle(fontSize: 14, fontFamily: "Lato", color: CustomColor.textBlack),
  titleLarge: TextStyle(fontSize: 20, fontFamily: "Lato", fontWeight: FontWeight.w700, color: CustomColor.textBlack),
  bodySmall: TextStyle(fontSize: 12, fontFamily: "Lato", color: Colors.grey),
  headlineLarge: TextStyle(fontSize: 24, fontFamily: "Lato", fontWeight: FontWeight.w900, color: CustomColor.textBlack),
  labelMedium: TextStyle(fontSize: 14, fontFamily: "Lato", fontWeight: FontWeight.w300, color: CustomColor.textBlack),
);

class CustomColor {
  static const Color lightBlue = Color(0xFFE9EFF0);
  static const Color blue = Color(0xFF3D959E);
  static const Color orange = Color(0xFFE67D22);
  static const Color textBlack = Color(0xFF343434);
}