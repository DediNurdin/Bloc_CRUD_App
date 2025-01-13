import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/splash/splash_bloc.dart';
import '../../../utils/utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(CheckTokenEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashTokenValid) {
            Navigator.pushReplacementNamed(context, '/bottomnav');
          } else if (state is SplashTokenExpired) {
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is SplashError) {
            Utils.showToast(state.message);
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return Container();
          },
        ),
      ),
    );
  }
}
