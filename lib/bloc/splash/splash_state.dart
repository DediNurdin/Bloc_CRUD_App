part of 'splash_bloc.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashTokenValid extends SplashState {}

class SplashTokenExpired extends SplashState {}

class SplashError extends SplashState {
  final String message;

  SplashError(this.message);
}
