import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  Future<bool> getTheme() async =>
      (await SharedPreferences.getInstance()).getBool('isDarkTheme') ??
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;

  Future<void> setTheme({required bool isDarkTheme}) async =>
      (await SharedPreferences.getInstance())
          .setBool('isDarkTheme', isDarkTheme);
}
