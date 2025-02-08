import '../../../utils/colors_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/theme_cubit.dart';
import '../../../utils/utils.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

enum SingingCharacter { darkMode, lightMode }

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        SingingCharacter? character = state.themeMode == ThemeMode.dark
            ? SingingCharacter.darkMode
            : SingingCharacter.lightMode;
        return Scaffold(
          appBar: AppBar(
            title: Text('Theme Application'),
          ),
          body: ListView(
            children: [
              CupertinoListTile(
                onTap: () {
                  context.read<ThemeCubit>().switchThemeDark();
                },
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                      fontSize: 13,
                      color: Utils.isDarkMode(context)
                          ? Colors.white
                          : Colors.black),
                ),
                trailing: CupertinoRadio<SingingCharacter>(
                  activeColor: colorDefaultGreen,
                  value: SingingCharacter.darkMode,
                  groupValue: character,
                  onChanged: (SingingCharacter? value) {},
                ),
              ),
              CupertinoListTile(
                onTap: () {
                  context.read<ThemeCubit>().switchThemeLight();
                },
                title: Text(
                  'Light Mode',
                  style: TextStyle(
                      fontSize: 13,
                      color: Utils.isDarkMode(context)
                          ? Colors.white
                          : Colors.black),
                ),
                trailing: CupertinoRadio<SingingCharacter>(
                  activeColor: colorDefaultGreen,
                  value: SingingCharacter.lightMode,
                  groupValue: character,
                  onChanged: (SingingCharacter? value) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
