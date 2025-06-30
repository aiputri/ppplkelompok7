import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/helpers/widgets/my_text_utils.dart';
import 'package:sikilap/model/room_model.dart';

class HotelDetailController extends MyController {
  List<RoomModel> room = [];
  int isSelectedTab = 0;

  late GoogleMapController mapController;

  LatLng center = LatLng(37.7749, -122.4194);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<String> dummyTexts = List.generate(12, (index) => MyTextUtils.getDummyText(60));

  List hotelImage = [
    "assets/images/dummy/hotel/hotel_1.jpg",
    "assets/images/dummy/hotel/hotel_2.jpg",
    "assets/images/dummy/hotel/hotel_3.jpg",
    "assets/images/dummy/hotel/hotel_4.jpg",
    "assets/images/dummy/hotel/hotel_5.jpg",
    "assets/images/dummy/hotel/hotel_6.jpg",
    "assets/images/dummy/hotel/hotel_7.jpg",
  ];

  List basicFacility = ["Free Wi-Fi", "Room Service", "Elevator Lift", "Laundry Service", "Power Backup", "Free Parking"];

  List paymentMode = ["Visa Card", "Master Card", "American express", "Debit Card", "Cash", "Online Banking"];

  List security = ["Security Guard", "CCTV", "Emergency Exit", "Doctor On Call"];

  List foodAndDrinks = ["Restaurant", "Bar"];

  List activities = ["GYM", "Game Zon", "Swimming Pool"];

  List<String> tabTitles = ["Rooms", "About", "Facility", "Location"];

  @override
  void onInit() {
    RoomModel.dummyList.then((value) {
      room = value.sublist(0, 4);
      update();
    });
    super.onInit();
  }

  void onSelectTab(int id) {
    isSelectedTab = id;
    update();
  }
}
