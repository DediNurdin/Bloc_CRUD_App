import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../models/user_model.dart';
import '../../repository/user_repository.dart';
import '../../utils/utils.dart';

part 'user_event.dart';
part 'user_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc(this.userRepository) : super(LoginInitial()) {
    on<SubmitLoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final token =
            await userRepository.loginUser(event.username, event.password);
        Utils.saveToken(token);
        String? tokenUser = await Utils.getToken();

        Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenUser!);
        if (kDebugMode) {
          print(decodedToken["sub"]);
        }
        Utils.saveUser(decodedToken['sub']);

        emit(LoginSuccess(tokenUser));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
