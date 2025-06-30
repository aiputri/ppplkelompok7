import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class BookingModel extends IdentifierModel {
  final String guestName, guestEmail, guestPhoneNumber, roomType, roomNumber, hotelName, hotelAddress, checkInDate, checkOutDate, paymentStatus, bookingStatus;
  final double totalPrice;

  BookingModel(
    super.id,
    this.guestName,
    this.guestEmail,
    this.guestPhoneNumber,
    this.roomType,
    this.roomNumber,
    this.hotelName,
    this.hotelAddress,
    this.checkInDate,
    this.checkOutDate,
    this.paymentStatus,
    this.bookingStatus,
    this.totalPrice,
  );

  static BookingModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String guestName = decoder.getString('guest_name');
    String guestEmail = decoder.getString('guest_email');
    String guestPhoneNumber = decoder.getString('guest_phone');
    String roomType = decoder.getString('room_type');
    String roomNumber = decoder.getString('room_number');
    String hotelName = decoder.getString('hotel_name');
    String hotelAddress = decoder.getString('hotel_address');
    String checkInDate = decoder.getString('check_in_date');
    String checkOutDate = decoder.getString('check_out_date');
    String paymentStatus = decoder.getString('payment_status');
    String bookingStatus = decoder.getString('booking_status');
    double totalPrice = decoder.getDouble('total_price');

    return BookingModel(decoder.getId, guestName, guestEmail, guestPhoneNumber, roomType, roomNumber, hotelName, hotelAddress, checkInDate, checkOutDate,
        paymentStatus, bookingStatus, totalPrice);
  }

  static List<BookingModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => BookingModel.fromJSON(e)).toList();
  }

  static List<BookingModel>? _dummyList;

  static Future<List<BookingModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/booking_list.json');
  }
}
