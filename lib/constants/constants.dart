import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColorsp {
//    Surface: #1A1A1A
// - onSurface: #FFFFFF
  static const Color primary = Color(0xFF1E6F9F);
  static const Color onsurface = Color(0xFFFFFFFF);

  static const Color surface = Color(0xFF1A1A1A);
}

TextStyle txtStyle = TextStyle(color: Colors.blue);

Decoration txtDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey),
    boxShadow: [
      BoxShadow(blurRadius: 10, color: Colors.grey, blurStyle: BlurStyle.outer)
    ],
    color: Colors.white,
    borderRadius: BorderRadius.circular(8));
Decoration txtDecorationDark = BoxDecoration(
    border: Border.all(color: Colors.grey),
    boxShadow: [
      BoxShadow(blurRadius: 10, color: Colors.grey, blurStyle: BlurStyle.outer)
    ],
    color: Colors.grey.shade800,
    borderRadius: BorderRadius.circular(8));

Widget customcircularindicator = Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  ),
);
