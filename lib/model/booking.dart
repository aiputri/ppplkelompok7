// lib/model/booking.dart
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class Booking extends IdentifierModel {
  final String kodePesanan; // Untuk "SKL-001"
  final String namaPelanggan;
  final String emailPelanggan;
  final String teleponPelanggan;
  final String jenisLayanan;
  final String alamatLayanan;
  final String jadwalLayanan;
  final String statusPembayaran;
  final String statusPesanan;
  final double totalBiaya;

  Booking(
    super.id, // ID numerik (contoh: 1, 2, 3)
    this.kodePesanan,
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

  static Booking fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    // Gunakan decoder.getId untuk mengambil ID numerik
    int id = decoder.getId; 
    String kodePesanan = decoder.getString('kode_pesanan');
    String namaPelanggan = decoder.getString('nama_pelanggan');
    String emailPelanggan = decoder.getString('email_pelanggan');
    String teleponPelanggan = decoder.getString('telepon_pelanggan');
    String jenisLayanan = decoder.getString('jenis_layanan');
    String alamatLayanan = decoder.getString('alamat_layanan');
    String jadwalLayanan = "${decoder.getString('tanggal_layanan')} ${decoder.getString('waktu_layanan')}";
    String statusPembayaran = decoder.getString('status_pembayaran');
    String statusPesanan = decoder.getString('status_pesanan');
    double totalBiaya = decoder.getDouble('total_biaya');

    return Booking(
      id,
      kodePesanan,
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

  static List<Booking> listFromJSON(List<dynamic> list) {
    return list.map((e) => Booking.fromJSON(e)).toList();
  }

  static List<Booking>? _dummyList;

  static Future<List<Booking>> get dummyList async {
    _dummyList ??= listFromJSON(json.decode(await getData()));
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/booking.json');
  }
}