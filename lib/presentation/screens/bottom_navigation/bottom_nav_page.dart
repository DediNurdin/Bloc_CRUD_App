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
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, stateTheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: stateNav.tabIndex == 1
                  ? ThemeUtils.darkTheme(false)
                  : Utils.isDarkMode(context)
                      ? ThemeUtils.darkTheme(false)
                      : ThemeUtils.lightTheme(false),
              darkTheme: ThemeUtils.darkTheme(false),
              themeMode: stateTheme.themeMode,
              home: PopScope(
                canPop: false,
                onPopInvokedWithResult: (bool didPop, dynamic ok) {
                  final difference = DateTime.now().difference(timeBackPressed);
                  final isExitWarning =
                      difference >= const Duration(seconds: 2);
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
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: Text('Wishlist'))
                                      : stateNav.tabIndex == 4
                                          ? SearchTransactionWidget()
                                          : Container(),
                          actions: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(CupertinoIcons.envelope)),
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
                              overlayColor:
                                  WidgetStatePropertyAll(Colors.transparent),
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
                      child: bottomNavScreen.elementAt(stateNav.tabIndex)),
                  bottomNavigationBar: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.1))),
                    child: BottomNavigationBar(
                      items: [
                        BottomNavigationBarItem(
                          icon: stateNav.tabIndex == 0
                              ? Icon(CupertinoIcons.square_grid_2x2_fill)
                              : Icon(CupertinoIcons.square_grid_2x2),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: stateNav.tabIndex == 1
                              ? Icon(CupertinoIcons.play_rectangle_fill)
                              : Icon(CupertinoIcons.play_rectangle),
                          label: 'Feed',
                        ),
                        BottomNavigationBarItem(
                          icon: stateNav.tabIndex == 2
                              ? Icon(CupertinoIcons.hexagon_fill)
                              : Icon(CupertinoIcons.hexagon),
                          label: 'Mall',
                        ),
                        BottomNavigationBarItem(
                          icon: stateNav.tabIndex == 3
                              ? Icon(CupertinoIcons.heart_fill)
                              : Icon(CupertinoIcons.heart),
                          label: 'Wishlist',
                        ),
                        BottomNavigationBarItem(
                          icon: stateNav.tabIndex == 4
                              ? Icon(CupertinoIcons.doc_richtext)
                              : Icon(CupertinoIcons.doc_plaintext),
                          label: 'Transaction',
                        ),
                      ],
                      currentIndex: stateNav.tabIndex,
                      onTap: (index) {
                        BlocProvider.of<BottomNavBloc>(context)
                            .add(TabChange(tabIndex: index));
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
