import '../../../bloc/cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc/bottom_nav/bottom_nav_bloc.dart';
import '../../../utils/colors.dart';
import '../../../utils/utils.dart';
import '../cart/cart_page.dart';
import '../feed/feed_page.dart';
import '../mall/item/search_mall_widget.dart';
import '../mall/mall_page.dart';
import '../product/item/search_product_widget.dart';
import '../product/product_page.dart';
import '../transactions/item/search_transaction_widget.dart';
import '../transactions/transactions_page.dart';
import '../wishlist/wish_list_page.dart';
import 'main_menu.dart';

const List<Widget> bottomNavScreen = [
  ProductPage(),
  FeedPage(),
  MallPage(),
  WishlistPage(),
  TransactionPage()
];

class BottomNavigationPage extends StatelessWidget {
  final int initialIndex;
  const BottomNavigationPage({
    this.initialIndex = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();

    return BlocProvider(
      create: (context) => BottomNavBloc()..add(SelectTabEvent(initialIndex)),
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, stateNav) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, stateTheme) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: stateNav.selectedIndex == 1
                    ? ThemeUtils.darkTheme(false)
                    : Utils.isDarkMode(context)
                        ? ThemeUtils.darkTheme(false)
                        : ThemeUtils.lightTheme(false),
                darkTheme: ThemeUtils.darkTheme(false),
                themeMode: stateTheme.themeMode,
                home: PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (bool didPop, dynamic ok) {
                    final difference =
                        DateTime.now().difference(timeBackPressed);
                    final isExitWarning =
                        difference >= const Duration(seconds: 2);
                    timeBackPressed = DateTime.now();
                    if (isExitWarning) {
                      Utils.showToast('Press back again to close', false);

                      didPop = false;
                    } else {
                      Fluttertoast.cancel();
                      SystemNavigator.pop();
                      didPop = true;
                    }
                  },
                  child: Scaffold(
                    appBar: stateNav.selectedIndex != 1
                        ? AppBar(
                            automaticallyImplyLeading: false,
                            scrolledUnderElevation: 0,
                            title: stateNav.selectedIndex == 0
                                ? SearchProductWidget()
                                : stateNav.selectedIndex == 2
                                    ? SearchMallWidget()
                                    : stateNav.selectedIndex == 3
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Text('Wishlist'))
                                        : stateNav.selectedIndex == 4
                                            ? SearchTransactionWidget()
                                            : Container(),
                            actions: [
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(CupertinoIcons.envelope)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(CupertinoIcons.bell)),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CartPage(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child:
                                          Icon(CupertinoIcons.shopping_cart))),
                              GestureDetector(
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
                                    child:
                                        Icon(CupertinoIcons.line_horizontal_3)),
                              )
                            ],
                          )
                        : null,
                    body: Center(
                        child:
                            bottomNavScreen.elementAt(stateNav.selectedIndex)),
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.1))),
                      child: BottomNavigationBar(
                        items: [
                          BottomNavigationBarItem(
                            icon: stateNav.selectedIndex == 0
                                ? Icon(CupertinoIcons.square_grid_2x2_fill)
                                : Icon(CupertinoIcons.square_grid_2x2),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: stateNav.selectedIndex == 1
                                ? Icon(CupertinoIcons.play_rectangle_fill)
                                : Icon(CupertinoIcons.play_rectangle),
                            label: 'Feed',
                          ),
                          BottomNavigationBarItem(
                            icon: stateNav.selectedIndex == 2
                                ? Icon(CupertinoIcons.hexagon_fill)
                                : Icon(CupertinoIcons.hexagon),
                            label: 'Mall',
                          ),
                          BottomNavigationBarItem(
                            icon: stateNav.selectedIndex == 3
                                ? Icon(CupertinoIcons.heart_fill)
                                : Icon(CupertinoIcons.heart),
                            label: 'Wishlist',
                          ),
                          BottomNavigationBarItem(
                            icon: stateNav.selectedIndex == 4
                                ? Icon(CupertinoIcons.doc_richtext)
                                : Icon(CupertinoIcons.doc_plaintext),
                            label: 'Transaction',
                          ),
                        ],
                        currentIndex: stateNav.selectedIndex,
                        onTap: (index) {
                          BlocProvider.of<BottomNavBloc>(context)
                              .add(SelectTabEvent(index));
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
