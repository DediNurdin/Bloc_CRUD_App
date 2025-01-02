import '../auth/profile_page.dart';
import '../../../utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Push Notifications
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('Push notifications'),
              trailing: CupertinoSwitch(
                value: true,
                onChanged: (value) {
                  // Handle switch toggle
                },
              ),
            ),
          ),
          const Divider(),

          // Help Section
          const SectionTitle(title: 'Help Center'),
          const SettingsOption(title: 'Get started'),
          const SettingsOption(title: 'Help & FAQ'),
          const Divider(),

          // Appearance Section
          const SectionTitle(
            title: 'Appearance',
          ),
          const SettingsOption(title: 'Theme', trailingText: 'Theme'),
          const SettingsOption(title: 'App Icon'),
          const Divider(),

          // Follow Us Section
          const SectionTitle(title: 'Follow Us'),
          const SettingsOption(title: 'Twitter'),
          const SettingsOption(title: 'Discord'),
          const Divider(),

          // About Section
          const SectionTitle(title: 'About'),
          const SettingsOption(title: 'Privacy policy'),
          const Divider(),

          const SectionTitle(title: 'Authentication'),
          const SettingsOption(title: 'Profile'),
          const SettingsOption(title: 'Logout'),

          const Divider(),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final String? trailingText;

  const SettingsOption({super.key, required this.title, this.trailingText});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeText =
            state.themeMode == ThemeMode.dark ? "Dark Theme" : "Light Theme";

        return Container(
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            trailing: trailingText != null
                ? Text(
                    themeText,
                    style: TextStyle(color: Colors.grey),
                  )
                : const Icon(Icons.chevron_right),
            onTap: () {
              switch (title) {
                case 'Profile':
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                  break;
                case 'Logout':
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
                  break;
                case 'Theme':
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: const Text('Select Theme'),
                      message: const Text('Your theme preference'),
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text('Dark'),
                          onPressed: () {
                            context.read<ThemeCubit>().switchThemeDark();
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('Light'),
                          onPressed: () {
                            context.read<ThemeCubit>().switchThemeLight();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                  break;
              }
            },
          ),
        );
      },
    );
  }
}
