import '../../../bloc/auth/auth_bloc.dart';
import '../../../utils/shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/utils.dart';
import '../myaccount/myaccount_page.dart';

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
                icon: Icon(Icons.close)),
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
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return ShimmerWidget.chipShimmer(context);
                } else if (state is AuthSuccess) {
                  final auth = state.auth;

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
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
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
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
                                        builder: (context) => MyAccountPage()),
                                  );
                                },
                                icon: Icon(Icons.settings_outlined))
                          ],
                        ),
                        Container(
                            width: 200,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              children: [
                                Text('Open Shop',
                                    style: TextStyle(
                                        color: Utils.isDarkMode(context)
                                            ? Colors.white
                                            : Colors.black)),
                                const Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  color: Utils.isDarkMode(context)
                                      ? Colors.white
                                      : Colors.black,
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            CupertinoFormSection(
              children: [
                CupertinoFormRow(
                  prefix: MainMenuItemWidget(
                    icon: CupertinoIcons.doc_append,
                    title: 'List Transactions',
                  ),
                  child: Container(),
                ),
                CupertinoFormRow(
                  prefix: MainMenuItemWidget(
                    icon: CupertinoIcons.star,
                    title: 'Review',
                  ),
                  child: Container(),
                ),
                CupertinoFormRow(
                  prefix: MainMenuItemWidget(
                    icon: CupertinoIcons.cart,
                    title: 'Buy Again',
                  ),
                  child: Container(),
                ),
                CupertinoFormRow(
                  prefix: MainMenuItemWidget(
                    icon: CupertinoIcons.heart,
                    title: 'Wishlist',
                  ),
                  child: Container(),
                ),
                CupertinoFormRow(
                  prefix: MainMenuItemWidget(
                    icon: CupertinoIcons.house_alt,
                    title: 'Store Folowing',
                  ),
                  child: Container(),
                ),
              ],
            ),
            CupertinoFormSection(
              children: [
                CupertinoFormRow(
                  prefix: MainMenuItemWidget(
                    icon: CupertinoIcons.person_crop_circle_fill_badge_exclam,
                    title: 'Order Complained',
                  ),
                  child: Container(),
                ),
                CupertinoFormRow(
                  prefix: MainMenuItemWidget(
                    icon: CupertinoIcons.headphones,
                    title: 'Help Care',
                  ),
                  child: Container(),
                ),
                CupertinoFormRow(
                  prefix: MainMenuItemWidget(
                    icon: CupertinoIcons.qrcode_viewfinder,
                    title: 'Scan QR',
                  ),
                  child: Container(),
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }
}
