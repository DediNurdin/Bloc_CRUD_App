import 'package:flutter/material.dart';

class Utils {
  static ThemeData styleDelegate() {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(),
      listTileTheme: const ListTileThemeData(
        titleAlignment: ListTileTitleAlignment.titleHeight,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        alignLabelWithHint: true,
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w100),
      ),
    );
  }

  static List<Widget> styleBuildActionAppBarSearch(
      void Function() onPressed, bool visible) {
    return [
      Visibility(
        visible: visible,
        child: InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: onPressed,
          child: const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Text('Batal',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          ),
        ),
      )
    ];
  }

  static Widget styleBuildLeadingAppBarSearch(void Function() onPressed) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_rounded,
      ),
      onPressed: onPressed,
    );
  }
}
