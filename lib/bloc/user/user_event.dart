part of 'user_bloc.dart';

abstract class UserEvent {}

class GetUserEvent extends UserEvent {}

class PostAddUserEvent extends UserEvent {
  String name;
  String email;
  String phone;

  PostAddUserEvent(this.name, this.email, this.phone);
  List<Object?> get props => [name, email, phone];
}

class PutEditUserEvent extends UserEvent {
  String id;
  String name;
  String email;
  String phone;

  PutEditUserEvent(this.id, this.name, this.email, this.phone);
  List<Object?> get props => [id, name, email, phone];
}

class DeleteUserEvent extends UserEvent {
  String id;
  DeleteUserEvent(
    this.id,
  );
  List<Object?> get props => [id];
}
