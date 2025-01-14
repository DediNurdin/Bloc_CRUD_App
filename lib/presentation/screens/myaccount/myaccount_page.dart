import 'theme_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/cubit/theme_cubit.dart';
import '../../../utils/skeleton_widget.dart';
import '../../../utils/utils.dart';
import '../auth/profile_page.dart';
import '../product/recomended_page.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return SkeletonWidget.chipSkeleton(context);
                } else if (state is AuthSuccess) {
                  final auth = state.auth;
                  return Row(
                    children: [
                      Container(
                          height: 75,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Utils.isDarkMode(context)
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300),
                          child: Icon(CupertinoIcons.person_fill)),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${auth.name.firstname.capitalize()} ${auth.name.lastname.capitalize()}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            auth.phone,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            auth.email,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                            );
                          },
                          icon: Icon(Icons.mode))
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
          CupertinoFormSection(children: [
            Column(
              children: [
                ListTile(
                  title: Text(
                    'Account Setting',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SettingsOption(
                    icon: CupertinoIcons.house, title: 'Your Adress'),
                SettingsOption(icon: CupertinoIcons.bag, title: 'Bank Account'),
                SettingsOption(
                    icon: CupertinoIcons.creditcard, title: 'Payment'),
                SettingsOption(
                    icon: CupertinoIcons.lock, title: 'Security Account'),
                SettingsOption(icon: CupertinoIcons.bell, title: 'Notification')
              ],
            ),
          ]),
          CupertinoFormSection(children: [
            ExpansionTile(
              title:
                  Text('Application Setting', style: TextStyle(fontSize: 15)),
              children: [
                const SettingsOption(
                    icon: Icons.light_mode,
                    title: 'Theme',
                    trailingText: 'Theme'),
              ],
            ),
          ]),
          CupertinoFormSection(children: [
            ListTile(
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
                                await Utils.removeTokenData();
                                await Utils.removeUserData();
                                if (!context.mounted) return;
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                            )
                          ],
                        ));
              },
              title: Text('Logout', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.logout_outlined),
              trailing: Icon(Icons.chevron_right),
            ),
          ]),
          RecomendedPage()
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
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  const SettingsOption(
      {super.key, required this.icon, required this.title, this.trailingText});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeText =
            state.themeMode == ThemeMode.dark ? "Dark Mode" : "Light Mode";

        return ListTile(
          leading: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                icon,
              )),
          title: Text(
            title,
            style: TextStyle(fontSize: 13),
          ),
          trailing: trailingText != null
              ? Text(
                  themeText,
                  style: TextStyle(color: Colors.grey),
                )
              : null,
          onTap: () {
            switch (title) {
              case 'Theme':
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ThemePage()),
                );
                break;
            }
          },
        );
      },
    );
  }
}
