part of 'user_bloc.dart';

abstract class UserEvent {}

class GetUserEvent extends UserEvent {}

abstract class RegisterEvent {}

class SubmitRegisterEvent extends RegisterEvent {
  final UserRegisterModel user;

  SubmitRegisterEvent(this.user);
}

class SubmitEditUserEvent extends RegisterEvent {
  final String userId;
  final UserRegisterModel user;

  SubmitEditUserEvent(this.userId, this.user);
}

class SubmitDeleteUserEvent extends UserEvent {
  final String userId;

  SubmitDeleteUserEvent(this.userId);
}

abstract class LoginEvent {}

class SubmitLoginEvent extends LoginEvent {
  final String username;
  final String password;

  SubmitLoginEvent({required this.username, required this.password});
}
