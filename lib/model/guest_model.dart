import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class GuestModel extends IdentifierModel {
  final String name, email, destination, arrivalDate, departureDate, specialRequest;
  final int age, numberOfGuest;

  GuestModel(super.id, this.name, this.email, this.destination, this.arrivalDate, this.specialRequest, this.age, this.numberOfGuest, this.departureDate);

  static GuestModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String name = decoder.getString('name');
    String email = decoder.getString('email');
    String destination = decoder.getString('destination');
    String arrivalDate = decoder.getString('arrivalDate');
    String departureDate = decoder.getString('departureDate');
    String specialRequest = decoder.getString('specialRequests');
    int age = decoder.getInt('age');
    int numberOfGuest = decoder.getInt('numberOfGuests');

    return GuestModel(decoder.getId, name, email, destination, arrivalDate, specialRequest, age, numberOfGuest, departureDate);
  }

  static List<GuestModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => GuestModel.fromJSON(e)).toList();
  }

  static List<GuestModel>? _dummyList;

  static Future<List<GuestModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/guest_list.json');
  }
}
