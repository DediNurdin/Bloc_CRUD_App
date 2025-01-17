import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';

class ThemeUtils {
  static ThemeData lightTheme(bool isSearchDelegate) {
    return ThemeData(
      fontFamily: 'Roboto-Regular',
      cupertinoOverrideTheme: const CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green,
          textTheme:
              CupertinoTextThemeData(actionTextStyle: TextStyle(fontSize: 13))),
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
          titleSpacing: 0,
          titleTextStyle: TextStyle(fontSize: 15, color: Colors.black),
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
          selectedLabelStyle: TextStyle(color: Colors.green, fontSize: 11),
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey.shade600,
          unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 11),
          backgroundColor: CupertinoColors.systemBackground),
      navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: 11,
          )),
          indicatorColor: CupertinoColors.secondarySystemBackground,
          elevation: 0,
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
        contentPadding: isSearchDelegate
            ? EdgeInsets.symmetric(horizontal: 15, vertical: 7)
            : null,
        isCollapsed: isSearchDelegate ? true : false,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: isSearchDelegate ? Colors.grey.shade600 : Colors.blue),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        errorBorder: OutlineInputBorder(
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
  }

  static ThemeData darkTheme(bool isSearchDelegate) {
    return ThemeData(
        fontFamily: 'Roboto-Regular',
        cupertinoOverrideTheme: const CupertinoThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.green,
            textTheme: CupertinoTextThemeData(
                actionTextStyle: TextStyle(fontSize: 13))),
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
            titleSpacing: 0,
            titleTextStyle: TextStyle(fontSize: 15, color: Colors.white),
            scrolledUnderElevation: 0,
            backgroundColor: CupertinoColors.darkBackgroundGray,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: CupertinoColors.darkBackgroundGray)),
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.darkBackgroundGray,
        listTileTheme:
            ListTileThemeData(tileColor: CupertinoColors.darkBackgroundGray),
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
            backgroundColor: Colors.grey.shade900,
            brightness: Brightness.dark),
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: CupertinoColors.darkBackgroundGray),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(color: Colors.green, fontSize: 11),
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey.shade600,
            unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 11),
            backgroundColor: CupertinoColors.darkBackgroundGray),
        navigationBarTheme: const NavigationBarThemeData(
            labelTextStyle: WidgetStatePropertyAll(TextStyle(
              fontSize: 11,
            )),
            indicatorColor: CupertinoColors.darkBackgroundGray,
            elevation: 0,
            backgroundColor: CupertinoColors.darkBackgroundGray),
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
          contentPadding: isSearchDelegate
              ? EdgeInsets.symmetric(horizontal: 15, vertical: 7)
              : null,
          isCollapsed: isSearchDelegate ? true : false,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade600),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isSearchDelegate ? Colors.grey.shade600 : Colors.blue),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CupertinoColors.destructiveRed),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ));
  }

  static SkeletonTheme themeSkeleton(Widget child) {
    return SkeletonTheme(
        shimmerGradient: LinearGradient(
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade200,
            Colors.grey.shade100,
          ],
          stops: [
            0.1,
            0.5,
            0.9,
          ],
        ),
        darkShimmerGradient: LinearGradient(
          colors: [
            Color(0xFF222222),
            Color(0xFF242424),
            Color(0xFF2B2B2B),
            Color(0xFF242424),
            Color(0xFF222222),
          ],
          stops: [
            0.0,
            0.2,
            0.5,
            0.8,
            1,
          ],
          begin: Alignment(-2.4, -0.2),
          end: Alignment(2.4, 0.2),
          tileMode: TileMode.clamp,
        ),
        child: child);
  }
}
