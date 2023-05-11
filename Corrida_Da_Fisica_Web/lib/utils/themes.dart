import 'package:flutter/material.dart';

import './constants.dart';

ThemeData defaultTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: DefaultPalette.orange,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: DefaultPalette.darkOrange,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      )
    ),

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
        foregroundColor: MaterialStateProperty.all<Color>(DefaultPalette.orange),
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
      secondary: SeventhGradePalette.yellow,
    ),
    textTheme:const TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: Colors.white,
      displayColor:  SeventhGradePalette.yellow,
    ),
    scaffoldBackgroundColor: Colors.black,

    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        )
    ),

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
        foregroundColor: MaterialStateProperty.all<Color>(SeventhGradePalette.yellow),
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
