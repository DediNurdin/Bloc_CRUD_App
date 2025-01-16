import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/cubit/theme_cubit.dart';
import '../../../utils/skeleton_widget.dart';
import '../../../utils/utils.dart';
import '../auth/profile_page.dart';
import '../product/recomended_page.dart';
import 'theme_page.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.list(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: BlocProvider(
                  create: (context) => AuthBloc()..add(GetAuthEvent()),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return SkeletonWidget.userAuthSkeleton(context);
                      } else if (state is AuthSuccess) {
                        final auth = state.auth;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Row(
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
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    auth.phone,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    auth.email,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
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
                                  icon: Icon(CupertinoIcons.pen))
                            ],
                          ),
                        );
                      }
                      return Text('');
                    },
                  ),
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
                    SettingsOption(
                        icon: CupertinoIcons.bag, title: 'Bank Account'),
                    SettingsOption(
                        icon: CupertinoIcons.creditcard, title: 'Payment'),
                    SettingsOption(
                        icon: CupertinoIcons.lock, title: 'Security Account'),
                    SettingsOption(
                        icon: CupertinoIcons.bell, title: 'Notification')
                  ],
                ),
              ]),
              CupertinoFormSection(children: [
                ExpansionTile(
                  title: Text('Application Setting',
                      style: TextStyle(fontSize: 15)),
                  children: [
                    SettingsOption(
                        icon: Utils.isDarkMode(context)
                            ? CupertinoIcons.moon
                            : CupertinoIcons.sun_max,
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
                                    await Utils.removeAllKeyPrefs();
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
                  leading: Icon(CupertinoIcons.square_arrow_right),
                  // trailing: Icon(CupertinoIcons.chevron_forward),
                ),
              ]),
              RecomendedPage()
            ],
          ),
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
