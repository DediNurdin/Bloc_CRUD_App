class Provinsi {
  Provinsi({
    required this.id,
    required this.nama,
    required this.idNasional,
  });

  final int id;
  final String nama;
  final String idNasional;

  factory Provinsi.fromJson(Map<String, dynamic> json) => Provinsi(
        id: json["id"],
        nama: json["nama"],
        idNasional: json["id_nasional"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "id_nasional": idNasional,
      };
}
