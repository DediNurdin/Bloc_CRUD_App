import '../voucher/voucher_page.dart';
import '../wallet/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bottom_nav/bottom_nav_bloc.dart';
import '../product/product_page.dart';
import '../settings/setting_page.dart';

List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.space_dashboard_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.wallet_giftcard_rounded),
    label: 'Voucher',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.wallet_rounded),
    label: 'Wallet',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings_rounded),
    label: 'Setting',
  ),
];

const List<Widget> bottomNavScreen = [
  ProductPage(),
  VoucherPage(),
  WalletPage(),
  SettingsPage()
];

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBloc, BottomNavState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            onTap: (index) {
              BlocProvider.of<BottomNavBloc>(context)
                  .add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    );
  }
}
