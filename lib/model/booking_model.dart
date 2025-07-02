import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class BookingModel extends IdentifierModel {
  // --- UBAH: Tambahkan kodePesanan ---
  final String kodePesanan;
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
    super.id, // ID numerik (contoh: 1, 2, 3)
    this.kodePesanan, // ID string (contoh: "SKL-001")
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

    // --- UBAH: Ambil ID numerik dan string secara terpisah ---
    int id = decoder.getId; // Mengambil 'id' dari JSON
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

    return BookingModel(
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

