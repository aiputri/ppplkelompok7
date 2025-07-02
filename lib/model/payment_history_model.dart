// lib/model/pembayaran_model.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class PembayaranModel extends IdentifierModel {
  final String kodePembayaran;
  final String kodePesanan;
  final String namaPelanggan;
  final double jumlahDibayar;
  final String mataUang;
  final String metodePembayaran;
  final String statusPembayaran;
  final DateTime tanggalPembayaran;
  final String idTransaksi;
  final String catatan;

  PembayaranModel(
    super.id,
    this.kodePembayaran,
    this.kodePesanan,
    this.namaPelanggan,
    this.jumlahDibayar,
    this.mataUang,
    this.metodePembayaran,
    this.statusPembayaran,
    this.tanggalPembayaran,
    this.idTransaksi,
    this.catatan,
  );

  static PembayaranModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    return PembayaranModel(
      decoder.getId,
      decoder.getString('kode_pembayaran'),
      decoder.getString('kode_pesanan'),
      decoder.getString('nama_pelanggan'),
      decoder.getDouble('jumlah_dibayar'),
      decoder.getString('mata_uang'),
      decoder.getString('metode_pembayaran'),
      decoder.getString('status_pembayaran'),
      decoder.getDateTime('tanggal_pembayaran'),
      decoder.getString('id_transaksi'),
      decoder.getString('catatan'),
    );
  }

  static List<PembayaranModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => PembayaranModel.fromJSON(e)).toList();
  }

  static Future<List<PembayaranModel>> get dummyList async {
    dynamic data = json.decode(await rootBundle.loadString('assets/data/payment_history.json'));
    return listFromJSON(data);
  }
}