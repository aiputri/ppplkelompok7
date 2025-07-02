// lib/model/guest_model.dart

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

// Walaupun bernama GuestModel, propertinya sekarang merefleksikan data Pelanggan
class GuestModel extends IdentifierModel {
  // --- UBAH: Properti disesuaikan dengan data pelanggan ---
  final String nama_pelanggan;
  final String email;
  final String nomor_telepon;
  final String alamat_utama;
  final int jumlah_pesanan;
  final String tanggal_bergabung;
  final String status;

  // --- UBAH: Constructor disesuaikan dengan properti baru ---
  GuestModel(
    super.id,
    this.nama_pelanggan,
    this.email,
    this.nomor_telepon,
    this.alamat_utama,
    this.jumlah_pesanan,
    this.tanggal_bergabung,
    this.status,
  );

  // --- UBAH: Fungsi fromJSON untuk mem-parsing data Pelanggan ---
  static GuestModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    int id = decoder.getId; // Mengambil 'id' dari JSON
    String nama_pelanggan = decoder.getString('nama_pelanggan');
    String email = decoder.getString('email');
    String nomor_telepon = decoder.getString('nomor_telepon');
    String alamat_utama = decoder.getString('alamat_utama');
    int jumlah_pesanan = decoder.getInt('jumlah_pesanan');
    String tanggal_bergabung = decoder.getString('tanggal_bergabung');
    String status = decoder.getString('status');

    // Mengembalikan objek GuestModel dengan data Pelanggan
    return GuestModel(
      id,
      nama_pelanggan,
      email,
      nomor_telepon,
      alamat_utama,
      jumlah_pesanan,
      tanggal_bergabung,
      status,
    );
  }

  // Fungsi listFromJSON tidak perlu diubah
  static List<GuestModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => GuestModel.fromJSON(e)).toList();
  }

  // Logika dummy data tetap sama
  static List<GuestModel>? _dummyList;

  static Future<List<GuestModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  // Pastikan file JSON yang diload adalah file data pelanggan yang baru
  static Future<String> getData() async {
    // Nama file ini harus sesuai dengan file JSON yang berisi data pelanggan
    return await rootBundle.loadString('assets/data/guest_list.json');
  }
}