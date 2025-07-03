// lib/model/my_booking_model.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class MyBookingModel extends IdentifierModel {
  // Properti yang tidak akan pernah berubah setelah dibuat
  final String bookingID;
  final String guestName;
  final String hotelName; // Ini adalah Nama Mitra
  final String roomType; // Ini adalah Nama Layanan
  final String checkInDate; // Ini kita gunakan untuk Jadwal Layanan
  final String checkOutDate; // Bisa tidak dipakai atau untuk info lain
  final String currency;
  final String bookingDate;
  final String specialRequests; // Kita gunakan untuk Jenis Kendaraan
  final int numberOfGuest;
  final double totalPrice;

  // Properti yang BISA DIUBAH statusnya
  String paymentMethod;
  String paymentStatus;
  String bookingStatus;

  MyBookingModel(
    super.id,
    this.bookingID,
    this.guestName,
    this.hotelName,
    this.roomType,
    this.checkInDate,
    this.checkOutDate,
    this.currency,
    this.paymentStatus,
    this.bookingStatus,
    this.bookingDate,
    this.specialRequests,
    this.paymentMethod,
    this.numberOfGuest,
    this.totalPrice,
  );

  static MyBookingModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String bookingID = decoder.getString('booking_id');
    String guestName = decoder.getString('guest_name');
    String hotelName = decoder.getString('hotel_name');
    String roomType = decoder.getString('room_type');
    String checkInDate = decoder.getString('check_in_date');
    String checkOutDate = decoder.getString('check_out_date');
    int numberOfGuest = decoder.getInt('number_of_guests');
    double totalPrice = decoder.getDouble('total_price');
    String currency = decoder.getString('currency');
    String paymentStatus = decoder.getString('payment_status');
    String bookingStatus = decoder.getString('booking_status');
    String bookingDate = decoder.getString('booking_date');
    String specialRequests = decoder.getString('special_requests');
    String paymentMethod = decoder.getString('payment_method');

    return MyBookingModel(
        decoder.getId,
        bookingID,
        guestName,
        hotelName,
        roomType,
        checkInDate,
        checkOutDate,
        currency,
        paymentStatus,
        bookingStatus,
        bookingDate,
        specialRequests,
        paymentMethod,
        numberOfGuest,
        totalPrice);
  }

  static List<MyBookingModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => MyBookingModel.fromJSON(e)).toList();
  }

  // Menggunakan metode tanpa cache agar perubahan di file JSON langsung terlihat saat development
  static Future<List<MyBookingModel>> get dummyList async {
    dynamic data = json.decode(await getData());
    return listFromJSON(data);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/my_booking.json');
  }
}
