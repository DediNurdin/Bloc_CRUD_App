part of 'region_bloc.dart';

sealed class RegionState extends Equatable {
  const RegionState();

  @override
  List<Object> get props => [];
}

final class RegionInitial extends RegionState {}

class ProvinsiLoading extends RegionState {}

class ProvinsiSuccess extends RegionState {
  final List<Provinsi> provinsi;
  const ProvinsiSuccess({
    required this.provinsi,
  });
}

class ProvinsiError extends RegionState {
  final String error;
  const ProvinsiError(this.error);
}

class KabKotLoading extends RegionState {}

class KabKotSuccess extends RegionState {
  final String message;
  const KabKotSuccess(this.message);
}

class KabKotError extends RegionState {
  final String error;
  const KabKotError(this.error);
}

class KecamatanLoading extends RegionState {}

class KecamatanSuccess extends RegionState {
  final String message;
  const KecamatanSuccess(this.message);
}

class KecamatanError extends RegionState {
  final String error;
  const KecamatanError(this.error);
}

class KelurahanLoading extends RegionState {}

class KelurahanSuccess extends RegionState {
  final String message;
  const KelurahanSuccess(this.message);
}

class KelurahanError extends RegionState {
  final String error;
  const KelurahanError(this.error);
}
