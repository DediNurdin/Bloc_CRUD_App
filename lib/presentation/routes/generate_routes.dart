import 'package:bloc_online_store/presentation/screens/user/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_nav/bottom_nav_bloc.dart';
import '../screens/bottom_navigation/bottom_nav_page.dart';

class RouteGenerator {
  final BottomNavBloc bottomNavBloc = BottomNavBloc();
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/bottomnav':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<BottomNavBloc>.value(
            value: bottomNavBloc,
            child: const BottomNavigationPage(),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
