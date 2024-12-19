part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<User> user;
  UserSuccess({
    required this.user,
  });
}

class AddUserLoadingState extends UserState {
  List<Object?> get props => [];
}

class AddUserSuccess extends UserState {
  final String message;
  AddUserSuccess(this.message);
}

class AddUserErrorState extends UserState {
  final String error;
  AddUserErrorState(this.error);
  List<Object?> get props => [error];
}

class EditUserLoadingState extends UserState {
  List<Object?> get props => [];
}

class EditUserSuccess extends UserState {
  final String message;
  EditUserSuccess(this.message);
}

class EditUserErrorState extends UserState {
  final String error;
  EditUserErrorState(this.error);
  List<Object?> get props => [error];
}

class DeleteUserLoadingState extends UserState {
  List<Object?> get props => [];
}

class DeleteUserSuccess extends UserState {
  final String message;
  DeleteUserSuccess(this.message);
}

class DeleteUserErrorState extends UserState {
  final String error;
  DeleteUserErrorState(this.error);
  List<Object?> get props => [error];
}
