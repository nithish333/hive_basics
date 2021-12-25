import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey, width: 3)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey, width: 2)),
        filled: true,
        hintStyle: const TextStyle(color: Colors.black)),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ElevatedButton.styleFrom(
    //         textStyle: TextStyle(fontSize: 18),
    //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //         primary: Colors.black,
    //         onPrimary: Colors.white)),
    textTheme: const TextTheme(
        headline1: TextStyle(
            color: Colors.black, fontSize: 45, fontWeight: FontWeight.bold)));

ThemeData darkTHeme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black, elevation: 0),
    scaffoldBackgroundColor: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black12)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey, width: 2)),
        fillColor: Colors.black45,
        filled: true,
        hintStyle: const TextStyle(color: Colors.white)),
    textTheme: const TextTheme(
        headline1: TextStyle(
            color: Colors.white, fontSize: 45, fontWeight: FontWeight.bold)));
