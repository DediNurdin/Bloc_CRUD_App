import '../product/item/product_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/cubit/theme_cubit.dart';
import '../../../bloc/product/product_bloc.dart';
import '../../../utils/shimmer_widget.dart';
import '../../../utils/utils.dart';
import '../auth/profile_page.dart';

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
                  return ShimmerWidget.chipShimmer(context);
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
                  title: Text('Account Setting'),
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
              title: Text('Application Setting'),
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
              title: Text('Logout'),
              leading: Icon(Icons.logout_outlined),
              trailing: Icon(Icons.chevron_right),
            ),
          ]),
          CupertinoFormSection(children: [
            SizedBox(
              height: kToolbarHeight,
              child: Row(
                children: [
                  Expanded(child: Divider()),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Recomended For You',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Divider()),
                ],
              ),
            ),
            BlocProvider(
              create: (context) => ProductBloc()..add(GetProductEvent()),
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return ShimmerWidget.gridShimmer(context);
                  }
                  if (state is ProductSuccess) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          crossAxisCount: 2,
                          childAspectRatio: 0.79,
                        ),
                        itemBuilder: (context, index) {
                          return ProductItemWidget(
                              product: state.products[index]);
                        },
                        itemCount: state.products.length,
                      ),
                    );
                  }

                  if (state is ProductFailure) {
                    return Center(
                      child: Text('No Data'),
                    );
                  }
                  return Container();
                },
              ),
            )
          ]),
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
          leading: Icon(icon),
          title: Text(
            title,
            style: TextStyle(fontSize: 15),
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
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: const Text('Select Theme'),
                    message: const Text('Your theme preference'),
                    actions: [
                      CupertinoActionSheetAction(
                        child: const Text('Dark Mode'),
                        onPressed: () {
                          context.read<ThemeCubit>().switchThemeDark();
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: const Text('Light Mode'),
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
        );
      },
    );
  }
}
