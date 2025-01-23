import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/theme_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ThemeRepository themeRepository,
  })  : _themeRepository = themeRepository,
        super(const ThemeState());

  final ThemeRepository _themeRepository;

  Future<void> getCurrentTheme() async {
    _themeRepository.getTheme().then((isDarkTheme) {
      if (isDarkTheme) {
        emit(state.copyWith(themeMode: ThemeMode.dark));
      } else if (!isDarkTheme) {
        emit(state.copyWith(themeMode: ThemeMode.light));
      } else {
        emit(state.copyWith(themeMode: ThemeMode.system));
      }
    });
  }

  Future<void> loadDynamicColor() async {
    final lightDynamic = await DynamicColorPlugin.getCorePalette();
    final darkDynamic = await DynamicColorPlugin.getCorePalette();

    if (lightDynamic != null && darkDynamic != null) {
      emit(state.copyWith(
        dynamicColorScheme: ColorScheme.fromSeed(
          seedColor: Color(lightDynamic.primary.get(0)),
        ),
      ));
    }
  }

  Future<void> switchThemeLight() async {
    await _themeRepository.setTheme(isDarkTheme: false);
    emit(state.copyWith(themeMode: ThemeMode.light));
  }

  Future<void> switchThemeDark() async {
    await _themeRepository.setTheme(isDarkTheme: true);
    emit(state.copyWith(themeMode: ThemeMode.dark));
  }

  Future<void> switchToSystemMode() async {
    emit(state.copyWith(themeMode: ThemeMode.system));
  }
}
