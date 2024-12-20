import 'dart:convert';

import 'package:bloc_online_store/models/user_model.dart';
import 'package:bloc_online_store/utils/utils.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<void> registerUser(UserRegisterModel user) async {
    final response = await http.post(
      Uri.parse('${Utils.baseUrlFakeApi}/users'),
      body: jsonEncode(user.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register user');
    }
  }

  Future<void> editUser(String userId, UserRegisterModel user) async {
    final response = await http.put(
      Uri.parse('${Utils.baseUrlFakeApi}/users/$userId'),
      body: jsonEncode(user.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit user');
    }
  }

  Future<String> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('${Utils.baseUrlFakeApi}/auth/login'),
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }
}
