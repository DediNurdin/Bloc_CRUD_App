import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../models/provinsi_mode.dart';
import '../../repository/region_repository.dart';

part 'region_event.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  final RegionRepository regionRepository;
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

  RegionBloc(this.regionRepository) : super(RegionInitial()) {
    on<GetProvinsiEvent>((event, emit) async {
      emit(ProvinsiLoading());
      try {
        final response = await http.get(Uri.parse(baseUrl + prov));
        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body)['data'];

          final List<Provinsi> provinsiList =
              data.map((item) => Provinsi.fromJson(item)).toList();

          emit(ProvinsiSuccess(provinsi: provinsiList));
        } else {
          emit(const ProvinsiError("Failed to load provinsi data"));
        }
      } catch (e) {
        emit(ProvinsiError("Error: $e"));
      }
    });

    on<GetKabKotEvent>((event, emit) async {
      emit(KabKotLoading());
      await regionRepository.getKabKot(event.provId);
      emit(const KabKotSuccess('Berhasil'));
    });

    on<GetKecamatanEvent>((event, emit) async {
      emit(KecamatanLoading());
      await regionRepository.getKec(event.kabKotId);
      emit(const KecamatanSuccess('Berhasil'));
    });

    on<GetKelurahanEvent>((event, emit) async {
      emit(KelurahanLoading());
      await regionRepository.getKel(event.kecId);
      emit(const KelurahanSuccess('Berhasil'));
    });
  }
}
