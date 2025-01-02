import 'dart:async';

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
      } else {
        emit(state.copyWith(themeMode: ThemeMode.light));
      }
    });
  }

  Future<void> switchThemeLight() async {
    await _themeRepository.setTheme(isDarkTheme: false);
    emit(state.copyWith(themeMode: ThemeMode.light));
  }

  Future<void> switchThemeDark() async {
    await _themeRepository.setTheme(isDarkTheme: true);
    emit(state.copyWith(themeMode: ThemeMode.dark));
  }
}
