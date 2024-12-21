import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_online_store/models/user_model.dart';
import 'package:bloc_online_store/utils/utils.dart';
import 'package:http/http.dart' as http;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<GetAuthEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final userId = await Utils.getUser();
        final response =
            await http.get(Uri.parse('${Utils.baseUrlFakeApi}/users/$userId'));
        if (response.statusCode == 200) {
          final auth = UserModel.fromJson(json.decode(response.body));
          emit(AuthSuccess(auth));
        } else {
          emit(AuthError('Failed to fetch Auth: ${response.reasonPhrase}'));
        }
      } catch (e) {
        emit(AuthError('An error occurred: $e'));
      }
    });
  }
}
