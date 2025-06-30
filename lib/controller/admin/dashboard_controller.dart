import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/booking.dart';
import 'package:sikilap/model/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class PolylineModel {
  PolylineModel(this.points);

  final List<MapLatLng> points;
}

class DashboardController extends MyController {
  String selectedTimeByLocation = "Year";
  late List<PolylineModel> polylines;
  late MapShapeSource dataSource;
  late int selectedIndex;
  late MapZoomPanBehavior zoomPanBehavior;
  late List<MapLatLng> polyline;
  List<Booking> booking = [];

  final List<ChartSampleData> chartData = [
    ChartSampleData(x: 'Jan', y: 10, yValue: 1000),
    ChartSampleData(x: 'Fab', y: 20, yValue: 2000),
    ChartSampleData(x: 'Mar', y: 15, yValue: 1500),
    ChartSampleData(x: 'Jun', y: 5, yValue: 500),
    ChartSampleData(x: 'Jul', y: 30, yValue: 3000),
    ChartSampleData(x: 'Aug', y: 20, yValue: 2000),
    ChartSampleData(x: 'Sep', y: 40, yValue: 4000),
    ChartSampleData(x: 'Oct', y: 60, yValue: 6000),
    ChartSampleData(x: 'Nov', y: 55, yValue: 5500),
    ChartSampleData(x: 'Dec', y: 38, yValue: 3000),
  ];
  final TooltipBehavior chart = TooltipBehavior(
    enable: true,
    format: 'point.x : point.yValue1 : point.yValue2',
  );

  void onSelectedTimeByLocation(String time) {
    selectedTimeByLocation = time;
    update();
  }

  @override
  void onInit() {
    Booking.dummyList.then((value) {
      booking = value.sublist(0, 5);
      update();
    });

    polyline = <MapLatLng>[
      MapLatLng(13.0827, 80.2707),
      MapLatLng(13.1746, 79.6117),
      MapLatLng(13.6373, 79.5037),
      MapLatLng(14.4673, 78.8242),
      MapLatLng(14.9091, 78.0092),
      MapLatLng(16.2160, 77.3566),
      MapLatLng(17.1557, 76.8697),
      MapLatLng(18.0975, 75.4249),
      MapLatLng(18.5204, 73.8567),
      MapLatLng(19.0760, 72.8777),
    ];

    polylines = <PolylineModel>[
      PolylineModel(polyline),
    ];
    dataSource = MapShapeSource.asset(
      'assets/data/world_map.json',
      shapeDataField: 'name',
    );

    zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 2,
      focalLatLng: MapLatLng(19.3173, 76.7139),
    );
    selectedIndex = -1;
    super.onInit();
  }
}
