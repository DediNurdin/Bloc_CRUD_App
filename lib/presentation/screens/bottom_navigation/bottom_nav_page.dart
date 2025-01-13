import 'main_menu.dart';
import '../cart/cart_page.dart';
import '../mall/item/search_mall_widget.dart';
import '../product/item/search_product_widget.dart';
import '../transactions/item/search_transaction_widget.dart';

import '../../../utils/colors.dart';

import '../../../utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc/bottom_nav/bottom_nav_bloc.dart';
import '../feed/feed_page.dart';
import '../mall/mall_page.dart';
import '../product/product_page.dart';
import '../transactions/transactions_page.dart';
import '../wishlist/wish_list_page.dart';

List<NavigationDestination> bottomNavItems = <NavigationDestination>[
  NavigationDestination(
    icon: Icon(Icons.space_dashboard_outlined),
    selectedIcon: Icon(Icons.space_dashboard_rounded),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(CupertinoIcons.play_rectangle),
    selectedIcon: Icon(CupertinoIcons.play_rectangle_fill),
    label: 'Feed',
  ),
  NavigationDestination(
    icon: Icon(CupertinoIcons.hexagon),
    selectedIcon: Icon(CupertinoIcons.hexagon_fill),
    label: 'Mall',
  ),
  NavigationDestination(
    icon: Icon(CupertinoIcons.heart),
    selectedIcon: Icon(CupertinoIcons.heart_fill),
    label: 'Wishlist',
  ),
  NavigationDestination(
    icon: Icon(CupertinoIcons.doc_text),
    selectedIcon: Icon(CupertinoIcons.doc_text_fill),
    label: 'Transaction',
  ),
];

const List<Widget> bottomNavScreen = [
  ProductPage(),
  FeedPage(),
  MallPage(),
  WishlistPage(),
  TransactionPage()
];

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
  });

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, stateNav) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: stateNav.tabIndex == 1
              ? ThemeUtils.darkTheme(false)
              : Utils.isDarkMode(context)
                  ? ThemeUtils.darkTheme(false)
                  : ThemeUtils.lightTheme(false),
          home: PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, dynamic ok) {
              final difference = DateTime.now().difference(timeBackPressed);
              final isExitWarning = difference >= const Duration(seconds: 2);
              timeBackPressed = DateTime.now();
              if (isExitWarning) {
                Utils.showToast('Press back again to close');

                didPop = false;
              } else {
                Fluttertoast.cancel();
                SystemNavigator.pop();
                didPop = true;
              }
            },
            child: Scaffold(
              appBar: stateNav.tabIndex != 1
                  ? AppBar(
                      automaticallyImplyLeading: false,
                      scrolledUnderElevation: 0,
                      title: stateNav.tabIndex == 0
                          ? SearchProductWidget()
                          : stateNav.tabIndex == 2
                              ? SearchMallWidget()
                              : stateNav.tabIndex == 3
                                  ? Text('Wishlist')
                                  : stateNav.tabIndex == 4
                                      ? SearchTransactionWidget()
                                      : Container(),
                      actions: [
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(CupertinoIcons.chat_bubble_2)),
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(CupertinoIcons.bell)),
                        InkWell(
                            overlayColor:
                                WidgetStatePropertyAll(Colors.transparent),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => CartPage()),
                              );
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(CupertinoIcons.shopping_cart))),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useSafeArea: true,
                                elevation: 0,
                                shape: BeveledRectangleBorder(),
                                builder: (context) => MainMenu());
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(CupertinoIcons.line_horizontal_3)),
                        )
                      ],
                    )
                  : null,
              body: Center(child: bottomNavScreen.elementAt(stateNav.tabIndex)),
              bottomNavigationBar: NavigationBar(
                indicatorShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                destinations: bottomNavItems,
                selectedIndex: stateNav.tabIndex,
                onDestinationSelected: (index) {
                  BlocProvider.of<BottomNavBloc>(context)
                      .add(TabChange(tabIndex: index));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
