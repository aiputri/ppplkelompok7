import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class BookingModel extends IdentifierModel {
  final String namaPelanggan;
  final String emailPelanggan;
  final String teleponPelanggan;
  final String jenisLayanan;
  final String alamatLayanan;
  final String jadwalLayanan;
  final String statusPembayaran;
  final String statusPesanan;
  final double totalBiaya;

  BookingModel(
    super.id, // ID di sini akan menggunakan nilai dari id_pesanan (String)
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

  static BookingModel fromJSON(Map<String, dynamic> json) {
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

    // Menggunakan idPesanan sebagai ID utama model
    return BookingModel(
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

  static List<BookingModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => BookingModel.fromJSON(e)).toList();
  }

  static List<BookingModel>? _dummyList;

  static Future<List<BookingModel>> get dummyList async {
    _dummyList ??= listFromJSON(json.decode(await getData()));
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/booking_list.json');
  }
}