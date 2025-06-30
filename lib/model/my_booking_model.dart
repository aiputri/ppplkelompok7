import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class MyBookingModel extends IdentifierModel {
  final String bookingID,
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
      paymentMethod;
  final int numberOfGuest;
  final double totalPrice;

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

    return MyBookingModel(decoder.getId, bookingID, guestName, hotelName, roomType, checkInDate, checkOutDate, currency, paymentStatus, bookingStatus,
        bookingDate, specialRequests, paymentMethod, numberOfGuest, totalPrice);
  }

  static List<MyBookingModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => MyBookingModel.fromJSON(e)).toList();
  }

  static List<MyBookingModel>? _dummyList;

  static Future<List<MyBookingModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/my_booking.json');
  }
}
