import 'package:bloc_online_store/bloc/splash/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(CheckTokenEvent()),
      child: Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashTokenValid) {
              Navigator.pushReplacementNamed(context, '/bottomnav');
            } else if (state is SplashTokenExpired) {
              Navigator.pushReplacementNamed(context, '/login');
            } else if (state is SplashError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              if (state is SplashLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return Center(
                child: Text(''),
              );
            },
          ),
        ),
      ),
    );
  }
}
