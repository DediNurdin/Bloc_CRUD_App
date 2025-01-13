import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeUtils {
  static ThemeData lightTheme(bool isAppSearch) {
    return ThemeData(
      fontFamily: 'Roboto-Regular',
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: Colors.green,
      ),
      dividerColor: Colors.transparent,
      useMaterial3: true,
      splashColor: Colors.transparent,
      drawerTheme:
          DrawerThemeData(backgroundColor: CupertinoColors.systemBackground),
      tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(fontSize: 12),
          dividerColor: Colors.transparent,
          unselectedLabelStyle: TextStyle(fontSize: 12),
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          labelColor: Colors.green,
          indicatorColor: Colors.green),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: Colors.black,
      ),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 17, color: Colors.black),
          scrolledUnderElevation: 0,
          backgroundColor: CupertinoColors.systemBackground,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: CupertinoColors.systemBackground)),
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemBackground,
      listTileTheme: ListTileThemeData(tileColor: Colors.grey.shade200),
      checkboxTheme: CheckboxThemeData(
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          checkColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return Colors.transparent;
          }),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.green;
            }
            return Colors.transparent;
          })),
      chipTheme: ChipThemeData(
          labelStyle: TextStyle(fontSize: 12, color: Colors.black),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.transparent)),
          backgroundColor: CupertinoColors.secondarySystemBackground,
          brightness: Brightness.light),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: CupertinoColors.systemBackground),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 11),
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: CupertinoColors.systemBackground),
      navigationBarTheme: const NavigationBarThemeData(
          indicatorColor: Colors.green,
          elevation: 2,
          backgroundColor: CupertinoColors.secondarySystemBackground),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green, foregroundColor: Colors.white),
      cardTheme: CardTheme(color: Colors.grey.shade200),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.green,
          linearMinHeight: 2,
          refreshBackgroundColor: CupertinoColors.extraLightBackgroundGray,
          circularTrackColor: Colors.transparent,
          linearTrackColor: Colors.transparent),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.green),
              foregroundColor: WidgetStatePropertyAll(Colors.white))),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: isAppSearch
            ? EdgeInsets.symmetric(horizontal: 15, vertical: 7)
            : null,
        isCollapsed: isAppSearch ? true : false,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(isAppSearch ? 5 : 10),
            topLeft: Radius.circular(isAppSearch ? 5 : 10),
            bottomRight: Radius.circular(isAppSearch ? 5 : 10),
            bottomLeft: Radius.circular(isAppSearch ? 5 : 10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: isAppSearch ? Colors.grey.shade600 : Colors.blue),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(isAppSearch ? 5 : 10),
            topLeft: Radius.circular(isAppSearch ? 5 : 10),
            bottomRight: Radius.circular(isAppSearch ? 5 : 10),
            bottomLeft: Radius.circular(isAppSearch ? 5 : 10),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CupertinoColors.destructiveRed),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(isAppSearch ? 5 : 10),
            topLeft: Radius.circular(isAppSearch ? 5 : 10),
            bottomRight: Radius.circular(isAppSearch ? 5 : 10),
            bottomLeft: Radius.circular(isAppSearch ? 5 : 10),
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme(bool isAppSearch) {
    return ThemeData(
        fontFamily: 'Roboto-Regular',
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: Colors.green,
        ),
        dividerColor: Colors.transparent,
        useMaterial3: true,
        splashColor: Colors.transparent,
        drawerTheme: DrawerThemeData(
            backgroundColor: CupertinoColors.darkBackgroundGray),
        tabBarTheme: TabBarTheme(
            labelStyle: TextStyle(fontSize: 12),
            dividerColor: Colors.transparent,
            unselectedLabelStyle: TextStyle(fontSize: 12),
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            labelColor: Colors.green,
            indicatorColor: Colors.green),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
        expansionTileTheme: ExpansionTileThemeData(
          iconColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 17, color: Colors.white),
            scrolledUnderElevation: 0,
            backgroundColor: CupertinoColors.darkBackgroundGray,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: CupertinoColors.darkBackgroundGray)),
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.darkBackgroundGray,
        listTileTheme: ListTileThemeData(tileColor: Colors.grey.shade600),
        checkboxTheme: CheckboxThemeData(
            side: BorderSide(color: Colors.grey),
            checkColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.transparent;
            }),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.green;
              }
              return Colors.transparent;
            })),
        chipTheme: ChipThemeData(
            labelStyle: TextStyle(fontSize: 12, color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.transparent)),
            backgroundColor: Colors.grey.shade800,
            brightness: Brightness.dark),
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: CupertinoColors.darkBackgroundGray),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 11),
            backgroundColor: CupertinoColors.darkBackgroundGray,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey.shade600),
        navigationBarTheme: const NavigationBarThemeData(
            indicatorColor: Colors.green,
            elevation: 2,
            backgroundColor: CupertinoColors.black),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.green, foregroundColor: Colors.white),
        cardTheme: CardTheme(color: Colors.grey.shade600),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.green,
            linearMinHeight: 2,
            refreshBackgroundColor: CupertinoColors.darkBackgroundGray,
            circularTrackColor: Colors.transparent,
            linearTrackColor: Colors.transparent),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                backgroundColor: WidgetStatePropertyAll(Colors.green),
                foregroundColor: WidgetStatePropertyAll(Colors.white))),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: isAppSearch
              ? EdgeInsets.symmetric(horizontal: 15, vertical: 7)
              : null,
          isCollapsed: isAppSearch ? true : false,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade600),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(isAppSearch ? 5 : 10),
              topLeft: Radius.circular(isAppSearch ? 5 : 10),
              bottomRight: Radius.circular(isAppSearch ? 5 : 10),
              bottomLeft: Radius.circular(isAppSearch ? 5 : 10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isAppSearch ? Colors.grey.shade600 : Colors.blue),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(isAppSearch ? 5 : 10),
              topLeft: Radius.circular(isAppSearch ? 5 : 10),
              bottomRight: Radius.circular(isAppSearch ? 5 : 10),
              bottomLeft: Radius.circular(isAppSearch ? 5 : 10),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CupertinoColors.destructiveRed),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(isAppSearch ? 5 : 10),
              topLeft: Radius.circular(isAppSearch ? 5 : 10),
              bottomRight: Radius.circular(isAppSearch ? 5 : 10),
              bottomLeft: Radius.circular(isAppSearch ? 5 : 10),
            ),
          ),
        ));
  }
}
