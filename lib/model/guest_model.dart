import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

// Walaupun bernama GuestModel, propertinya sekarang merefleksikan data Mitra
class GuestModel extends IdentifierModel {
  final String nama_mitra;
  final String nomor_telepon;
  final String area_layanan;
  final String status;
  final String tanggal_gabung;
  final double rating;

  // Constructor diubah sesuai properti baru
  GuestModel(
    super.id,
    this.nama_mitra,
    this.nomor_telepon,
    this.area_layanan,
    this.rating,
    this.status,
    this.tanggal_gabung,
  );

  // Fungsi fromJSON diubah untuk mem-parsing data Mitra
  static GuestModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    // Ambil ID dari field 'id_mitra' atau 'id'
    int id = decoder.hasKey('id_mitra') ? decoder.getInt('id_mitra') : decoder.getId;
    
    String nama_mitra = decoder.getString('nama_mitra');
    String nomor_telepon = decoder.getString('nomor_telepon');
    String area_layanan = decoder.getString('area_layanan');
    double rating = decoder.getDouble('rating');
    String status = decoder.getString('status');
    String tanggal_gabung = decoder.getString('tanggal_gabung');

    // Kembalikan objek GuestModel dengan data Mitra
    return GuestModel(id, nama_mitra, nomor_telepon, area_layanan, rating, status, tanggal_gabung);
  }

  // Fungsi listFromJSON tidak perlu diubah
  static List<GuestModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => GuestModel.fromJSON(e)).toList();
  }

  // Logika dummy data tetap sama, tetapi akan mem-parsing file JSON yang berbeda
  static List<GuestModel>? _dummyList;

  static Future<List<GuestModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  // Pastikan file JSON yang diload adalah file data mitra yang baru
  static Future<String> getData() async {
    // Anda bisa mengganti nama file ini jika perlu, misal 'data_mitra.json'
    return await rootBundle.loadString('assets/data/guest_list.json');
  }
}