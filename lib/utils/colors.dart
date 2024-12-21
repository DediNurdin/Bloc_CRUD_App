import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: CupertinoColors.systemBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: CupertinoColors.systemBackground,
  ),
  brightness: Brightness.light,
  primaryColor: Colors.green,
  listTileTheme: ListTileThemeData(tileColor: Colors.grey.shade200),
  chipTheme: ChipThemeData(
      iconTheme: const IconThemeData(color: Colors.green),
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      brightness: Brightness.light),
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: CupertinoColors.systemBackground),
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(selectedItemColor: Colors.green),
  navigationBarTheme: const NavigationBarThemeData(
      indicatorColor: Colors.green,
      elevation: 2,
      backgroundColor: CupertinoColors.secondarySystemBackground),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green, foregroundColor: Colors.white),
  cardTheme: CardTheme(color: Colors.grey.shade200),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.green),
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
  ),
);
final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
    appBarTheme: AppBarTheme(
      backgroundColor: CupertinoColors.darkBackgroundGray,
    ),
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    listTileTheme: ListTileThemeData(tileColor: Colors.grey.shade600),
    chipTheme: ChipThemeData(
        iconTheme: const IconThemeData(color: Colors.green),
        backgroundColor: CupertinoColors.darkBackgroundGray,
        brightness: Brightness.dark),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: CupertinoColors.darkBackgroundGray),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey.shade600),
    navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.green,
        elevation: 2,
        backgroundColor: CupertinoColors.black),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.green, foregroundColor: Colors.white),
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
