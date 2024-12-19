part of 'region_bloc.dart';

abstract class RegionEvent {}

class GetProvinsiEvent extends RegionEvent {}

class GetKabKotEvent extends RegionEvent {
  String provId;
  GetKabKotEvent(
    this.provId,
  );
  List<Object?> get props => [provId];
}

class GetKecamatanEvent extends RegionEvent {
  String kabKotId;
  GetKecamatanEvent(
    this.kabKotId,
  );
  List<Object?> get props => [kabKotId];
}

class GetKelurahanEvent extends RegionEvent {
  String kecId;
  GetKelurahanEvent(
    this.kecId,
  );
  List<Object?> get props => [kecId];
}
