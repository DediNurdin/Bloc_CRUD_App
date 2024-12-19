import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/add_user.dart';

class UserRepository {
  final baseUrl = 'http://192.168.0.100:8000/user/';

  Future<CrudUserModel> addUser(
    String name,
    String email,
    String phone,
  ) async {
    Map body = {
      'name': name,
      'email': email,
      'phone': phone,
    };

    http.Response response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final result = jsonDecode(response.body);

      return CrudUserModel.fromJson(result);
    } else {
      if (kDebugMode) {
        print('error_repository ${response.statusCode}');
      }
      throw Exception(response.reasonPhrase ?? 'Unknown error');
    }
  }

  Future<CrudUserModel> editUser(
    String id,
    String name,
    String email,
    String phone,
  ) async {
    Map body = {
      'name': name,
      'email': email,
      'phone': phone,
    };

    http.Response response = await http.put(
      Uri.parse(baseUrl + id),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final result = jsonDecode(response.body);

      return CrudUserModel.fromJson(result);
    } else {
      if (kDebugMode) {
        print('error_repository ${response.statusCode}');
      }
      throw Exception(response.reasonPhrase ?? 'Unknown error');
    }
  }

  Future deleteUser(
    String id,
  ) async {
    http.Response response = await http.delete(
      Uri.parse(baseUrl + id),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {
      if (kDebugMode) {
        print('error_repository ${response.statusCode}');
      }
      throw Exception(response.reasonPhrase ?? 'Unknown error');
    }
  }
}
