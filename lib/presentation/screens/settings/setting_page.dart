import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/theme_cubit.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          title: const Text('Setting'),
        ),
        body: ListView(
          children: [
            CupertinoFormSection(
              header: const Text('Configuration'),
              children: [
                CupertinoFormRow(
                  prefix: const Row(
                    children: [
                      Icon(Icons.draw),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Theme')
                    ],
                  ),
                  child: BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return CupertinoSwitch(
                        value: state.themeMode == ThemeMode.dark,
                        onChanged: (_) async =>
                            context.read<ThemeCubit>().switchTheme(),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
