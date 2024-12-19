import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/provinsi_mode.dart';

class RegionRepository {
  static String baseUrl = 'https://v2.pakar-proteksi.pakar-asuransi.com/api';
  final prov = '/master/provinsi';
  static String kecamatan(String kotaId) {
    return "$baseUrl/master/kecamatan?kota_id=$kotaId";
  }

  static String kelurahan(String kecId) {
    return "$baseUrl/master/kelurahan?kecamatan_id=$kecId";
  }

  static String kabupaten(String provId) {
    return "$baseUrl/master/kab_kota?provinsi_id=$provId";
  }

  List<Provinsi> provinsiList = [];
  List<dynamic> kabKotList = [];
  List<dynamic> kecList = [];
  List<dynamic> kelList = [];

  Future<void> getProvinsi() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + prov));

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final data = json['data'];

        return provinsiList = data;
      } else {
        if (kDebugMode) {
          print('Failed to load data kabupaten: ${response.reasonPhrase}');
        }
        throw Exception('Failed to load data kabupaten');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      throw Exception('Failed to load data kabupaten');
    }
  }

  Future<void> getKabKot(String provId) async {
    try {
      final response = await http.get(Uri.parse(kabupaten(provId)));

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final data = json['data'];

        kabKotList = data;
      } else {
        if (kDebugMode) {
          print('Failed to load data kabupaten: ${response.reasonPhrase}');
        }
        throw Exception('Failed to load data kabupaten');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      throw Exception('Failed to load data kabupaten');
    }
  }

  Future<void> getKec(String kabKotId) async {
    try {
      final response = await http.get(Uri.parse(kecamatan(kabKotId)));

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final data = json['data'];

        kecList = data;
      } else {
        if (kDebugMode) {
          print('Failed to load data kabupaten: ${response.reasonPhrase}');
        }
        throw Exception('Failed to load data kabupaten');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      throw Exception('Failed to load data kabupaten');
    }
  }

  Future<void> getKel(String kecId) async {
    try {
      final response = await http.get(Uri.parse(kelurahan(kecId)));

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final data = json['data'];

        kelList = data;
      } else {
        if (kDebugMode) {
          print('Failed to load data kabupaten: ${response.reasonPhrase}');
        }
        throw Exception('Failed to load data kabupaten');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      throw Exception('Failed to load data kabupaten');
    }
  }
}
