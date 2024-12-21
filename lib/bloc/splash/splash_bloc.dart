import 'package:bloc/bloc.dart';
import 'package:bloc_online_store/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckTokenEvent>((event, emit) async {
      emit(SplashLoading());
      try {
        final String? token = await Utils.getToken();

        if (token == null) {
          emit(SplashTokenExpired());
        } else {
          bool isTokenExpired = isTokenExpiredFromIat(token);

          if (isTokenExpired) {
            emit(SplashTokenExpired());
          } else {
            emit(SplashTokenValid());
          }
        }
      } catch (e) {
        emit(SplashError('An error occurred: $e'));
      }
    });
  }
}

bool isTokenExpiredFromIat(String token, {int validityDurationInHours = 24}) {
  try {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    int? issuedAt = decodedToken['iat'];

    if (issuedAt != null) {
      DateTime issuedAtDate =
          DateTime.fromMillisecondsSinceEpoch(issuedAt * 1000);
      DateTime expiryDate =
          issuedAtDate.add(Duration(hours: validityDurationInHours));

      return DateTime.now().isAfter(expiryDate);
    } else {
      return true;
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error decoding token: $e');
    }
    return true;
  }
}
