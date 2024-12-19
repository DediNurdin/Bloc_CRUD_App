import '../../../bloc/bottom_nav/bottom_nav_bloc.dart';
import '../product/product_page.dart';
import '../settings/setting_page.dart';
import '../user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<NavigationDestination> bottomNavItems = <NavigationDestination>[
  NavigationDestination(
    icon: Icon(
      Icons.home_filled,
      color: Colors.grey.shade600,
    ),
    selectedIcon: const Icon(
      Icons.home_filled,
      color: Colors.white,
    ),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(
      Icons.person,
      color: Colors.grey.shade600,
    ),
    selectedIcon: const Icon(
      Icons.person,
      color: Colors.white,
    ),
    label: 'User',
  ),
  NavigationDestination(
    icon: Icon(
      Icons.settings,
      color: Colors.grey.shade600,
    ),
    selectedIcon: const Icon(
      Icons.settings,
      color: Colors.white,
    ),
    label: 'Setting',
  ),
];

const List<Widget> bottomNavScreen = [ProductPage(), UserPage(), SettingPage()];

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBloc, BottomNavState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
          bottomNavigationBar: NavigationBar(
            destinations: bottomNavItems,
            selectedIndex: state.tabIndex,
            onDestinationSelected: (int index) {
              BlocProvider.of<BottomNavBloc>(context)
                  .add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    );
  }
}
