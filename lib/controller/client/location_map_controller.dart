import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class LocationMapController extends MyController {
  late PageController pageViewController;
  late MapTileLayerController mapController;
  late MapZoomPanBehavior zoomPanBehavior;
  List<WonderDetails> worldWonders = <WonderDetails>[];
  RxInt currentSelectedIndex = 5.obs;
  int previousSelectedIndex = 0;
  late double cardHeight;
  late bool canUpdateFocalLatLng;
  late bool canUpdateZoomLevel;
  late int tappedMarkerIndex;
  String? urlTemplate;

  @override
  void onInit() {
    super.onInit();
    worldWonders.addAll([
      WonderDetails(
        place: 'Chichen Itza',
        state: 'Yucatan',
        country: 'Mexico',
        latitude: 20.6843,
        longitude: -88.5678,
        description: "Mayan ruins...",
        imagePath: 'assets/images/dummy/map/maps_chichen_itza.jpg',
        tooltipImagePath: 'assets/images/dummy/map/maps-chichen-itza.jpg',
      ),
      WonderDetails(
          place: 'Machu Picchu',
          state: 'Cuzco',
          country: 'Peru',
          latitude: -13.1631,
          longitude: -72.5450,
          description: 'An Inca citadel built in the mid-1400s. It was not widely known until the early twentieth century.',
          imagePath: 'assets/images/dummy/map/maps_machu_pichu.jpg',
          tooltipImagePath: 'assets/images/dummy/map/maps-machu-picchu.jpg'),
      WonderDetails(
          place: 'Christ the Redeemer',
          state: 'Rio de Janeiro',
          country: 'Brazil',
          latitude: -22.9519,
          longitude: -43.2105,
          description: 'An enormous statue of Jesus Christ with open arms, constructed between 1922 and 1931.',
          imagePath: 'assets/images/dummy/map/maps_christ_redeemer.jpg',
          tooltipImagePath: 'assets/images/dummy/map/maps-christ-the-redeemer.jpg'),
      WonderDetails(
          place: 'Colosseum',
          state: 'Regio III Isis et Serapis',
          country: 'Rome',
          latitude: 41.8902,
          longitude: 12.4922,
          description:
              'Built between A.D. 70 and 80, it could accommodate 50,000 to 80,000 people in tiered seating. It is one of the most popular tourist attractions in Europe.',
          imagePath: 'assets/images/dummy/map/maps_colosseum.jpg',
          tooltipImagePath: 'assets/images/dummy/map/maps-colosseum.jpg'),
      WonderDetails(
          place: 'Petra',
          state: "Ma'an Governorate",
          country: 'Jordan',
          latitude: 30.3285,
          longitude: 35.4444,
          description: 'An ancient stone city located in southern Jordan. It became the capital city for the Nabataeans around the fourth century BC.',
          imagePath: 'assets/images/dummy/map/maps_petra.jpg',
          tooltipImagePath: 'assets/images/dummy/map/maps-petra.jpg'),
      WonderDetails(
          place: 'Taj Mahal',
          state: 'Uttar Pradesh',
          country: 'India',
          latitude: 27.1751,
          longitude: 78.0421,
          description:
              'A white marble mausoleum in Agra, India. It was commissioned in A.D. 1632 by the Mughal emperor Shah Jahan to hold the remains of his favorite wife. It was completed in 1653.',
          imagePath: 'assets/images/dummy/map/maps_taj_mahal.jpg',
          tooltipImagePath: 'assets/images/dummy/map/maps-tajmahal.jpg'),
      WonderDetails(
          place: 'Great Wall of China',
          state: 'Beijing',
          country: 'China',
          latitude: 40.4319,
          longitude: 116.5704,
          description:
              'A series of walls and fortifications built along the northern border of China to protect Chinese states from invaders. Counting all of its offshoots, its length is more than 13,000 miles.',
          imagePath: 'assets/images/dummy/map/maps_great_wall_of_china.jpg',
          tooltipImagePath: 'assets/images/dummy/map/maps-great-wall-of-china.png'),
    ]);

    zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 3,
      maxZoomLevel: 10,
      focalLatLng: MapLatLng(worldWonders[currentSelectedIndex.value].latitude, worldWonders[currentSelectedIndex.value].longitude),
      enableDoubleTapZooming: true,
    );

    mapController = MapTileLayerController();
    pageViewController = PageController(initialPage: currentSelectedIndex.value, viewportFraction: 0.8);

    canUpdateFocalLatLng = true;
    canUpdateZoomLevel = true;
    cardHeight = 110.0;
  }

  @override
  void onClose() {
    pageViewController.dispose();
    mapController.dispose();
    super.onClose();
  }

  void updateFocalLatLng(bool value) {
    canUpdateFocalLatLng = value;
  }

  void handlePageChange(int index) {
    if (!canUpdateFocalLatLng) {
      if (tappedMarkerIndex == index) {
        updateSelectedCard(index);
      }
    } else if (canUpdateFocalLatLng) {
      updateSelectedCard(index);
    }
  }

  void updateSelectedCard(int index) {
    previousSelectedIndex = currentSelectedIndex.value;
    currentSelectedIndex.value = index;

    if (canUpdateFocalLatLng) {
      zoomPanBehavior.focalLatLng = MapLatLng(worldWonders[currentSelectedIndex.value].latitude, worldWonders[currentSelectedIndex.value].longitude);
    }

    mapController.updateMarkers(<int>[currentSelectedIndex.value, previousSelectedIndex]);
    canUpdateFocalLatLng = true;
  }
}

class WonderDetails {
  const WonderDetails(
      {required this.place,
      required this.state,
      required this.country,
      required this.imagePath,
      required this.latitude,
      required this.longitude,
      required this.description,
      required this.tooltipImagePath});

  final String place;
  final String state;
  final String country;
  final double latitude;
  final double longitude;
  final String description;
  final String imagePath;
  final String tooltipImagePath;
}
