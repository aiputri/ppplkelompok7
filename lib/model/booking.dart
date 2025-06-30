import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class Booking extends IdentifierModel {
  final String name, checkIn, checkOut, proof, payment, amount, rooms, action;
  final List<String> roomNo;

  Booking(super.id, this.name, this.checkIn, this.checkOut, this.proof, this.payment, this.amount, this.rooms, this.action, this.roomNo);

  static Booking fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String name = decoder.getString('name');
    String checkIn = decoder.getString('check_in');
    String checkOut = decoder.getString('check_out');
    String proof = decoder.getString('proof');
    String payment = decoder.getString('payment');
    String amount = decoder.getString('amount');
    String rooms = decoder.getString('rooms');
    String action = decoder.getString('action');
    List<String>? roomNo = decoder.getObjectListOrNull('room_no');

    return Booking(decoder.getId, name, checkIn, checkOut, proof, payment, amount, rooms, action, roomNo!);
  }

  static List<Booking> listFromJSON(List<dynamic> list) {
    return list.map((e) => Booking.fromJSON(e)).toList();
  }

  static List<Booking>? _dummyList;

  static Future<List<Booking>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/booking.json');
  }
}
