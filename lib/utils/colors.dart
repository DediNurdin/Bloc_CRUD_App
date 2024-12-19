import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    brightness: Brightness.light,
    primaryColor: Colors.green,
    listTileTheme: ListTileThemeData(tileColor: Colors.grey.shade200),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey.shade600),
    navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.green,
        elevation: 2,
        backgroundColor: CupertinoColors.secondarySystemBackground),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.green, foregroundColor: Colors.white),
    switchTheme:
        const SwitchThemeData(thumbColor: WidgetStatePropertyAll(Colors.green)),
    cardTheme: CardTheme(color: Colors.grey.shade200),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.green),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.green),
            foregroundColor: WidgetStatePropertyAll(Colors.white))),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade600),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: CupertinoColors.destructiveRed),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
    ));
final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    listTileTheme: ListTileThemeData(tileColor: Colors.grey.shade600),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey.shade600),
    navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.green,
        elevation: 2,
        backgroundColor: CupertinoColors.black),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.green, foregroundColor: Colors.white),
    switchTheme: SwitchThemeData(
        trackColor: WidgetStatePropertyAll(Colors.grey.shade200),
        thumbColor: const WidgetStatePropertyAll(Colors.green)),
    cardTheme: CardTheme(color: Colors.grey.shade600),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.green),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.green),
            foregroundColor: WidgetStatePropertyAll(Colors.white))),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade600),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: CupertinoColors.destructiveRed),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
    ));
