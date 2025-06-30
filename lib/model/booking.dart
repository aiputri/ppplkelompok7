import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

// Kelas ini sekarang merepresentasikan sebuah pesanan di Sikilap
class Booking extends IdentifierModel {
  // Properti disesuaikan dengan data pesanan Sikilap
  final String namaPelanggan;
  final String emailPelanggan;
  final String teleponPelanggan;
  final String jenisLayanan;
  final String alamatLayanan;
  final String jadwalLayanan;
  final String statusPembayaran;
  final String statusPesanan;
  final double totalBiaya;

  // Constructor diubah untuk properti baru
  Booking(
    super.id, // ID pesanan (contoh: "SKL-001")
    this.namaPelanggan,
    this.emailPelanggan,
    this.teleponPelanggan,
    this.jenisLayanan,
    this.alamatLayanan,
    this.jadwalLayanan,
    this.statusPembayaran,
    this.statusPesanan,
    this.totalBiaya,
  );

  // Fungsi fromJSON diubah total untuk mem-parsing data pesanan Sikilap
  static Booking fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String idPesanan = decoder.getString('id_pesanan');
    String namaPelanggan = decoder.getString('nama_pelanggan');
    String emailPelanggan = decoder.getString('email_pelanggan');
    String teleponPelanggan = decoder.getString('telepon_pelanggan');
    String jenisLayanan = decoder.getString('jenis_layanan');
    String alamatLayanan = decoder.getString('alamat_layanan');
    String jadwalLayanan = decoder.getString('jadwal_layanan');
    String statusPembayaran = decoder.getString('status_pembayaran');
    String statusPesanan = decoder.getString('status_pesanan');
    double totalBiaya = decoder.getDouble('total_biaya');

    // Mengembalikan objek Booking dengan data yang sudah diparsing
    return Booking(
      idPesanan as int,
      namaPelanggan,
      emailPelanggan,
      teleponPelanggan,
      jenisLayanan,
      alamatLayanan,
      jadwalLayanan,
      statusPembayaran,
      statusPesanan,
      totalBiaya,
    );
  }

  // Fungsi ini tidak perlu diubah
  static List<Booking> listFromJSON(List<dynamic> list) {
    return list.map((e) => Booking.fromJSON(e)).toList();
  }

  // Logika dummy data akan mengambil dari file booking.json yang baru
  static List<Booking>? _dummyList;

  static Future<List<Booking>> get dummyList async {
    // Menggunakan operator ??= untuk menyederhanakan
    _dummyList ??= listFromJSON(json.decode(await getData()));
    return _dummyList!;
  }

  // Pastikan file ini berisi data pesanan Sikilap yang baru
  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/booking.json');
  }
}