import 'package:intl/intl.dart';

class Produk {
  int? id;
  String namaProduk;
  String kodeProduk;
  double hargaBeli;
  double hargaJual;
  double? hargaGrosir;
  int stok;
  String? kategoriProduk;
  String? gambarProduk;
  DateTime? tanggalKadaluarsa;

  Produk({
    this.id,
    required this.namaProduk,
    required this.kodeProduk,
    required this.hargaBeli,
    required this.hargaJual,
    this.hargaGrosir,
    required this.stok,
    this.kategoriProduk,
    this.gambarProduk,
    this.tanggalKadaluarsa,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'NamaProduk': namaProduk,
      'KodeProduk': kodeProduk,
      'Harga_Beli': hargaBeli,
      'Harga_Jual': hargaJual,
      'Harga_Grosir': hargaGrosir,
      'Stok': stok,
      'KategoriProduk': kategoriProduk,
      'GambarProduk': gambarProduk,
      'TanggalKadaluarsa': tanggalKadaluarsa != null
          ? DateFormat('yyyy-MM-dd').format(tanggalKadaluarsa!)
          : null,
    };
  }

  factory Produk.fromMap(Map<String, dynamic> map) {
    return Produk(
      id: map['ID'],
      namaProduk: map['NamaProduk'],
      kodeProduk: map['KodeProduk'],
      hargaBeli: map['Harga_Beli'],
      hargaJual: map['Harga_Jual'],
      hargaGrosir: map['Harga_Grosir'],
      stok: map['Stok'],
      kategoriProduk: map['KategoriProduk'],
      gambarProduk: map['GambarProduk'],
      tanggalKadaluarsa: map['TanggalKadaluarsa'] != null
          ? DateTime.parse(map['TanggalKadaluarsa'])
          : null,
    );
  }
}
