import 'package:flutter/material.dart';

import './constants.dart';

enum AppTheme { defaultTheme, seventhGradeTheme }

ThemeData defaultTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: DefaultPalette.orange,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: DefaultPalette.darkOrange,
        tertiary: DefaultPalette.peach,
        primary: DefaultPalette.orange,
        onBackground: Colors.black,
        background: Colors.white),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gapPadding: 5.0,
        borderSide: BorderSide(color: DefaultPalette.orange, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gapPadding: 5.0,
        borderSide: BorderSide(color: DefaultPalette.peach, width: 1),
      ),
      iconColor: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      textStyle: MaterialStateTextStyle.resolveWith(
          (states) => const TextStyle(decoration: TextDecoration.underline)),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        )),
        backgroundColor:
            MaterialStateProperty.all<Color>(DefaultPalette.orange),
        textStyle: MaterialStateTextStyle.resolveWith(
            (states) => const TextStyle(fontSize: 20)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        side: MaterialStateProperty.all(const BorderSide(
            color: DefaultPalette.orange,
            width: 1.0,
            style: BorderStyle.solid)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor:
            MaterialStateProperty.all<Color>(DefaultPalette.orange),
        textStyle: MaterialStateTextStyle.resolveWith(
            (states) => const TextStyle(fontSize: 20)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: DefaultPalette.darkOrange,
      toolbarHeight: 100.0,
      titleTextStyle: TextStyle(fontSize: 30, color: Colors.white),
    ),
    fontFamily: 'SourceSansPro');

ThemeData seventhGradeTheme = ThemeData(
    primaryColor: SeventhGradePalette.brightPurple,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: SeventhGradePalette.brightPurple,
        secondary: SeventhGradePalette.yellow,
        tertiary: SeventhGradePalette.lightPurple,
        onBackground: Colors.white,
      background: SeventhGradePalette.darkBlue
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: Colors.white,
      displayColor: SeventhGradePalette.yellow,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gapPadding: 5.0,
        borderSide:
            BorderSide(color: SeventhGradePalette.brightPurple, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gapPadding: 5.0,
        borderSide:
            BorderSide(color: SeventhGradePalette.lightPurple, width: 1),
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      textStyle: MaterialStateTextStyle.resolveWith(
          (states) => const TextStyle(decoration: TextDecoration.underline)),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        )),
        backgroundColor:
            MaterialStateProperty.all<Color>(SeventhGradePalette.darkPurple),
        textStyle: MaterialStateTextStyle.resolveWith(
            (states) => const TextStyle(fontSize: 20)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        side: MaterialStateProperty.all(const BorderSide(
            color: SeventhGradePalette.yellow,
            width: 1.0,
            style: BorderStyle.solid)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        foregroundColor:
            MaterialStateProperty.all<Color>(SeventhGradePalette.yellow),
        textStyle: MaterialStateTextStyle.resolveWith(
            (states) => const TextStyle(fontSize: 20)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: SeventhGradePalette.darkBlue,
      toolbarHeight: 100.0,
      titleTextStyle: TextStyle(fontSize: 30, color: Colors.white),
    ),
    fontFamily: 'SourceSansPro');
