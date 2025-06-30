import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sikilap/helpers/services/json_decoder.dart';
import 'package:sikilap/model/identifier_model.dart';

class HotelModel extends IdentifierModel {
  final String image, ownerName, phoneNumber, email, hotelName, cityName;

  HotelModel(super.id, this.ownerName, this.phoneNumber, this.email, this.hotelName, this.cityName, this.image);

  static HotelModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String image = decoder.getString('image');
    String ownerName = decoder.getString('owner_name');
    String phoneNumber = decoder.getString('phone_number');
    String email = decoder.getString('email');
    String hotelName = decoder.getString('hotel_name');
    String cityName = decoder.getString('city_name');

    return HotelModel(decoder.getId, ownerName, phoneNumber, email, hotelName, cityName, image);
  }

  static List<HotelModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => HotelModel.fromJSON(e)).toList();
  }

  static List<HotelModel>? _dummyList;

  static Future<List<HotelModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/hotel_data.json');
  }
}
