part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final ColorScheme? dynamicColorScheme;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.dynamicColorScheme,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    ColorScheme? dynamicColorScheme,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      dynamicColorScheme: dynamicColorScheme ?? this.dynamicColorScheme,
    );
  }

  @override
  List<Object?> get props => [themeMode, dynamicColorScheme];
}
