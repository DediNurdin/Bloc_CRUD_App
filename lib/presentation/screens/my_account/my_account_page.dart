import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';
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
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverList.list(
            children: [
              BlocProvider(
                create: (context) => AuthBloc()..add(GetAuthEvent()),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: SkeletonWidget.userAuthSkeleton(context, 2),
                      );
                    } else if (state is AuthSuccess) {
                      final auth = state.auth;
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
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
                    return Container();
                  },
                ),
              ),
              Utils.customColumn(
                context,
                Column(children: [
                  ListTile(
                    title: Text(
                      'Account Setting',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  CupertinoFormRow(
                    child: MyAccountItemWidget(
                        icon: CupertinoIcons.house, title: 'Your Adress'),
                  ),
                  CupertinoFormRow(
                    child: MyAccountItemWidget(
                        icon: CupertinoIcons.bag, title: 'Bank Account'),
                  ),
                  CupertinoFormRow(
                    child: MyAccountItemWidget(
                        icon: CupertinoIcons.creditcard, title: 'Payment'),
                  ),
                  CupertinoFormRow(
                    child: MyAccountItemWidget(
                        icon: CupertinoIcons.lock, title: 'Security Account'),
                  ),
                  CupertinoFormRow(
                    child: MyAccountItemWidget(
                        icon: CupertinoIcons.bell, title: 'Notification'),
                  ),
                ]),
              ),
              Utils.customColumn(
                context,
                Column(children: [
                  ExpansionTile(
                    title: Text('Application Setting',
                        style: TextStyle(fontSize: 15)),
                    children: [
                      CupertinoFormRow(
                        child: MyAccountItemWidget(
                            icon: Utils.isDarkMode(context)
                                ? CupertinoIcons.moon
                                : CupertinoIcons.sun_max,
                            title: 'Theme',
                            trailingText: 'Theme'),
                      ),
                    ],
                  ),
                ]),
              ),
              Utils.customColumn(
                context,
                Column(children: [
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
                  ),
                ]),
              ),
              RecomendedPage()
            ],
          ),
        ],
      ),
    );
  }
}
