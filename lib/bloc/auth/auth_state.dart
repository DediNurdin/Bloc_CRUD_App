part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel auth;

  AuthSuccess(this.auth);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
