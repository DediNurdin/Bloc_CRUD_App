import 'package:bloc_online_store/bloc/auth/auth_bloc.dart';
import 'package:bloc_online_store/bloc/splash/splash_bloc.dart';

import 'bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cubit/theme_cubit.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/region/region_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'presentation/routes/generate_routes.dart';
import 'repository/region_repository.dart';
import 'repository/theme_repository.dart';
import 'repository/user_repository.dart';
import 'utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          create: (context) => RegisterBloc(UserRepository()),
        ),
        BlocProvider(
          create: (context) => UserBloc(UserRepository())..add(GetUserEvent()),
        ),
        BlocProvider(
          create: (context) => ProductBloc()..add(GetProductEvent()),
        ),
        BlocProvider(
          create: (context) =>
              ProductCategoriesBloc()..add(GetProductCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) => ProductDetailBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(GetCartEvent()),
        ),
        BlocProvider(
          create: (context) => RegionBloc(RegionRepository()),
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
        builder: (BuildContext context, ThemeState state) => MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state.themeMode,
          title: 'Bloc STM Learn',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: RouteGenerator().generateRoute,
        ),
      ),
    );
  }
}
