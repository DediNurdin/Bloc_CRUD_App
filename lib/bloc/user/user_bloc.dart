import 'package:bloc_online_store/models/user_model.dart';
import 'package:bloc_online_store/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      final response = await http.get(
        Uri.parse('${Utils.baseUrlFakeApi}/users'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      emit(UserSuccess(user: userModelFromJson(response.body)));
    });

    on<SubmitDeleteUserEvent>((event, emit) async {
      emit(DeleteUserLoading());
      await http.delete(
        Uri.parse('${Utils.baseUrlFakeApi}/users/${event.userId}'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      emit(DeleteUserSuccess());
      add(GetUserEvent());
    });
  }
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc(this.userRepository) : super(RegisterInitial()) {
    on<SubmitRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        await userRepository.registerUser(event.user);
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });

    on<SubmitEditUserEvent>((event, emit) async {
      emit(EditUserLoading());
      try {
        await userRepository.editUser(event.userId, event.user);
        emit(EditUserSuccess());
      } catch (e) {
        emit(EditUserFailure(e.toString()));
      }
    });
  }
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc(this.userRepository) : super(LoginInitial()) {
    on<SubmitLoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final token =
            await userRepository.loginUser(event.username, event.password);
        emit(LoginSuccess(token));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
