import 'package:bloc_online_store/utils/utils.dart';
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
  WishListPage(),
  TransactionsPage()
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
    return BlocConsumer<BottomNavBloc, BottomNavState>(
      listener: (context, state) {},
      builder: (context, state) {
        return PopScope(
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
            body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
            bottomNavigationBar: NavigationBar(
              destinations: bottomNavItems,
              selectedIndex: state.tabIndex,
              onDestinationSelected: (index) {
                BlocProvider.of<BottomNavBloc>(context)
                    .add(TabChange(tabIndex: index));
              },
            ),
          ),
        );
      },
    );
  }
}
