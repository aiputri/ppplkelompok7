// lib/model/room_model.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:stay_place/helpers/services/json_decoder.dart';
import 'package:stay_place/model/identifier_model.dart';

class RoomModel extends IdentifierModel {
  final int hotelId; // <-- TAMBAHKAN FIELD BARU
  final String roomType, bedType, image, view;
  final double pricePerNight;
  final List amenities, guestService, inclusion;
  final bool availability, smoking;
  final int capacity, floor;
  late bool isFavourite = false;

  RoomModel(
    super.id,
    this.hotelId, // <-- TAMBAHKAN DI CONSTRUCTOR
    this.roomType,
    this.bedType,
    this.pricePerNight,
    this.amenities,
    this.availability,
    this.image,
    this.guestService,
    this.inclusion,
    this.view,
    this.smoking,
    this.capacity,
    this.floor,
    this.isFavourite,
  );

  static RoomModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    int hotelId = decoder.getInt('hotel_id'); // <-- AMBIL NILAI hotel_id
    String roomType = decoder.getString('room_type');
    String bedType = decoder.getString('bed_type');
    String image = decoder.getString('image');
    String view = decoder.getString('view');
    double pricePerNight = decoder.getDouble('price_per_night');
    List amenities = decoder.getObjectList('amenities');
    List guestService = decoder.getObjectList('guest_service');
    List inclusion = decoder.getObjectList('inclusion');
    bool availability = decoder.getBool('availability');
    bool smoking = decoder.getBool('smoking');
    int capacity = decoder.getInt('capacity');
    int floor = decoder.getInt('floor');
    bool isFavourite = decoder.getBool('isFavourite');

    return RoomModel(
        decoder.getId,
        hotelId, // <-- MASUKKAN KE CONSTRUCTOR
        roomType,
        bedType,
        pricePerNight,
        amenities,
        availability,
        image,
        guestService,
        inclusion,
        view,
        smoking,
        capacity,
        floor,
        isFavourite);
  }

  static List<RoomModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => RoomModel.fromJSON(e)).toList();
  }

  static List<RoomModel>? _dummyList;

  static Future<List<RoomModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/room_data.json');
  }
}
