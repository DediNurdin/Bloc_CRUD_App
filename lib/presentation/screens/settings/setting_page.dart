import 'package:bloc_online_store/presentation/screens/auth/profile_page.dart';
import 'package:bloc_online_store/utils/utils.dart';
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
            ),
            CupertinoFormSection(header: Text('Account'), children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: CupertinoFormRow(
                    prefix: const Row(
                      children: [
                        Icon(CupertinoIcons.person_fill),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Profile')
                      ],
                    ),
                    child: SizedBox(
                        height: kTextTabBarHeight,
                        child: Icon(CupertinoIcons.chevron_right))),
              ),
              InkWell(
                onTap: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('Log Out'),
                            content: Text('Are you sure want to log out ?'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                child: Text('Yes'),
                                onPressed: () async {
                                  if (!context.mounted) return;
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                  await Utils.removeTokenData();
                                },
                              )
                            ],
                          ));
                },
                child: CupertinoFormRow(
                    prefix: const Row(
                      children: [
                        Icon(Icons.logout_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Log Out')
                      ],
                    ),
                    child: SizedBox(
                        height: kTextTabBarHeight,
                        child: Icon(CupertinoIcons.chevron_right))),
              ),
            ])
          ],
        ));
  }
}
