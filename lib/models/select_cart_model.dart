class Toko {
  int id;
  List<Barang> barang;
  bool isSelectedAll;

  Toko({required this.id, required this.barang, this.isSelectedAll = false});
}

class Barang {
  int id;
  String nama;
  int harga;
  int jumlah;
  bool isSelected;

  Barang(
      {required this.id,
      required this.nama,
      required this.harga,
      required this.jumlah,
      this.isSelected = false});
}
