import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bottom_nav/bottom_nav_bloc.dart';
import '../product/product_page.dart';
import '../settings/setting_page.dart';
import '../user/user_page.dart';

List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.house_fill),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.person_fill),
    label: 'User',
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.settings),
    label: 'Setting',
  ),
];

const List<Widget> bottomNavScreen = [ProductPage(), UserPage(), SettingPage()];

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
