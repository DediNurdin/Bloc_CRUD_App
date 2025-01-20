import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/skeleton_widget.dart';
import '../../../utils/utils.dart';
import '../my_account/my_account_page.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    super.key,
  });

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.clear)),
            Text(
              'Main Menu',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocProvider(
              create: (context) => AuthBloc()..add(GetAuthEvent()),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      child: SkeletonWidget.userAuthSkeleton(context),
                    );
                  } else if (state is AuthSuccess) {
                    final auth = state.auth;
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                                  Row(
                                    children: [
                                      Assets.icons.wallet
                                          .image(height: 17, width: 17),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'USD 150.4892',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyAccountPage()),
                                    );
                                  },
                                  icon: Icon(CupertinoIcons.gear))
                            ],
                          ),
                          SizedBox(
                              width: 200,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    minimumSize:
                                        WidgetStatePropertyAll(Size(0, 30))),
                                onPressed: () {},
                                iconAlignment: IconAlignment.end,
                                child: Row(
                                  children: [
                                    Text(
                                      'Open Shop',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      size: 14,
                                      CupertinoIcons.right_chevron,
                                      color: Utils.isDarkMode(context)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ],
                                ),
                              )),
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
              Column(
                children: [
                  CupertinoFormRow(
                    child: MainMenuItemWidget(
                      icon: CupertinoIcons.doc_append,
                      title: 'List Transactions',
                    ),
                  ),
                  CupertinoFormRow(
                    child: MainMenuItemWidget(
                      icon: CupertinoIcons.star,
                      title: 'Review',
                    ),
                  ),
                  CupertinoFormRow(
                    child: MainMenuItemWidget(
                      icon: CupertinoIcons.cart,
                      title: 'Buy Again',
                    ),
                  ),
                  CupertinoFormRow(
                    child: MainMenuItemWidget(
                      icon: CupertinoIcons.heart,
                      title: 'Wishlist',
                    ),
                  ),
                  CupertinoFormRow(
                    child: MainMenuItemWidget(
                      icon: CupertinoIcons.house_alt,
                      title: 'Store Folowing',
                    ),
                  ),
                ],
              ),
            ),
            Utils.customColumn(
              context,
              Column(
                children: [
                  CupertinoFormRow(
                    child: MainMenuItemWidget(
                      icon: CupertinoIcons.person_crop_circle_fill_badge_exclam,
                      title: 'Order Complained',
                    ),
                  ),
                  CupertinoFormRow(
                    child: MainMenuItemWidget(
                      icon: CupertinoIcons.headphones,
                      title: 'Help Care',
                    ),
                  ),
                  CupertinoFormRow(
                    child: MainMenuItemWidget(
                      icon: CupertinoIcons.qrcode_viewfinder,
                      title: 'Scan QR',
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }
}
