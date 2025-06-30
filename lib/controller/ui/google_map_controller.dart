import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sikilap/controller/my_controller.dart';

class GoogleMapPageController extends MyController {
  late GoogleMapController mapController;

  LatLng center = LatLng(37.7749, -122.4194);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
