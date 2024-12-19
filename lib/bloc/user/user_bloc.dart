import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
import '../../repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      final response = await http.get(
        Uri.parse('http://192.168.0.106:8000/user'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      emit(UserSuccess(user: userFromJson(response.body)));
    });

    on<PostAddUserEvent>((event, emit) async {
      emit(AddUserLoadingState());
      try {
        await userRepository.addUser(event.name, event.email, event.phone);

        emit(AddUserSuccess('Berhasil Menambahkan User'));

        add(GetUserEvent());
      } catch (e) {
        if (kDebugMode) {
          print('error_repository: $e');
        }
        emit(AddUserErrorState('Terjadi kesalahan saat menambahkan user'));
      }
    });

    on<PutEditUserEvent>((event, emit) async {
      emit(EditUserLoadingState());
      try {
        await userRepository.editUser(
            event.id, event.name, event.email, event.phone);

        emit(EditUserSuccess('Berhasil Edit User'));

        add(GetUserEvent());
      } catch (e) {
        if (kDebugMode) {
          print('error_repository: $e');
        }
        emit(EditUserErrorState('Terjadi kesalahan saat Edit User'));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      emit(DeleteUserLoadingState());
      try {
        await userRepository.deleteUser(event.id);

        emit(DeleteUserSuccess('Berhasil Menghapus User'));

        add(GetUserEvent());
      } catch (e) {
        if (kDebugMode) {
          print('error_repository: $e');
        }
        emit(DeleteUserErrorState('Terjadi kesalahan saat Menghapus User'));
      }
    });
  }
}
