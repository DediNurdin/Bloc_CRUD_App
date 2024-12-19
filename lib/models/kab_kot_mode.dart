class KabKot {
  KabKot({
    required this.id,
    required this.nama,
    required this.idNasional,
    required this.provinsiId,
    required this.provinsi,
    required this.idNasionalProvinsi,
  });

  final int id;
  final String nama;
  final String idNasional;
  final int provinsiId;
  final String provinsi;
  final String idNasionalProvinsi;

  factory KabKot.fromJson(Map<String, dynamic> json) => KabKot(
        id: json["id"],
        nama: json["nama"],
        idNasional: json["id_nasional"],
        provinsiId: json["provinsi_id"],
        provinsi: json["provinsi"],
        idNasionalProvinsi: json["id_nasional_provinsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "id_nasional": idNasional,
        "provinsi_id": provinsiId,
        "provinsi": provinsiId,
        "id_nasional_provinsi": provinsiId,
      };
}
