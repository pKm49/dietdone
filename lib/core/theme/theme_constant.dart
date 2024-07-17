import 'package:flutter/material.dart';

import '../constraints/const_colors.dart';

ThemeData themeData = ThemeData(
    //appBar
    appBarTheme: AppBarTheme(),
    //ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        fixedSize: MaterialStateProperty.all(const Size(500, 60)),
      ).merge(ElevatedButton.styleFrom(backgroundColor: kBlackColor)),
    ),

    //textStyle
    textTheme: const TextTheme(
      titleSmall: TextStyle(color: Colors.grey),
      titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      labelLarge: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),

    //TextFormField
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
          fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey),
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBlackColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            color: Color(0xFFDADADA)), // Set your desired color
      ),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(10)),
      fillColor: textFieldColor,
      filled: true,
    ));
