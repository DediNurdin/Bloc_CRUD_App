import 'bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/cart/cart_bloc.dart';
import 'bloc/cubit/theme_cubit.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/splash/splash_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'presentation/routes/generate_routes.dart';
import 'repository/theme_repository.dart';
import 'repository/user_repository.dart';
import 'utils/colors.dart';

class ShoppyApp extends StatelessWidget {
  const ShoppyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(UserRepository()),
        ),
        BlocProvider(
          create: (context) => BottomNavBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc()..add(GetAllProductEvent()),
        ),
        BlocProvider(
          create: (context) => ProductLimitBloc()..add(GetProductLimitEvent()),
        ),
        BlocProvider(
          create: (context) =>
              ProductCategoriesBloc()..add(GetProductCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) => ProductByCategoriesBloc()
            ..add(GetProductByCategoriesEvent(category: '')),
        ),
        BlocProvider(
          create: (context) => ProductDetailBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ProductSearchBloc()..add(GetProductSearchEvent()),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(GetCartEvent()),
        ),
        BlocProvider(
          create: (context) => CartCheckBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(GetAuthEvent()),
        ),
        BlocProvider(
            create: (BuildContext context) =>
                ThemeCubit(themeRepository: ThemeRepository())
                  ..getCurrentTheme())
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (BuildContext context, ThemeState state) =>
              ThemeUtils.themeSkeleton(
                MaterialApp(
                  theme: ThemeUtils.lightTheme(false),
                  darkTheme: ThemeUtils.darkTheme(false),
                  themeMode: state.themeMode,
                  title: 'Shoppy',
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/',
                  onGenerateRoute: RouteGenerator().generateRoute,
                ),
              )),
    );
  }
}
