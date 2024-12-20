part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<UserModel> user;
  UserSuccess({
    required this.user,
  });
}

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);
}

class EditUserLoading extends RegisterState {}

class EditUserSuccess extends RegisterState {}

class EditUserFailure extends RegisterState {
  final String error;

  EditUserFailure(this.error);
}

class DeleteUserInitial extends UserState {}

class DeleteUserLoading extends UserState {}

class DeleteUserSuccess extends UserState {}

class DeleteUserFailure extends UserState {
  final String error;

  DeleteUserFailure(this.error);
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess(this.token);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
