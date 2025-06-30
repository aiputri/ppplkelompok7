import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/client/location_map_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class LocationMapScreen extends StatefulWidget {
  const LocationMapScreen({super.key});

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> with UIMixin {
  LocationMapController controller = Get.put(LocationMapController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'location_map_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Location Map",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Location Map', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard(
                  shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                  height: 700,
                  paddingAll: 0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/dummy/map/maps_grid.png',
                          repeat: ImageRepeat.repeat,
                        ),
                      ),
                      SfMaps(
                        layers: <MapLayer>[
                          if (controller.worldWonders.isNotEmpty)
                            MapTileLayer(
                              urlTemplate: controller.urlTemplate ?? 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              zoomPanBehavior: controller.zoomPanBehavior,
                              controller: controller.mapController,
                              initialMarkersCount: controller.worldWonders.length,
                              tooltipSettings: MapTooltipSettings(color: Colors.transparent),
                              markerTooltipBuilder: (BuildContext context, int index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                                    MyContainer(
                                      width: 150,
                                      height: 80,
                                      color: Colors.grey,
                                      child: Image.asset(controller.worldWonders[index].tooltipImagePath, fit: BoxFit.fill),
                                    ),
                                    MyContainer(
                                      padding: MySpacing.only(left: 10, top: 5, bottom: 5),
                                      width: 150,
                                      color: Colors.white,
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                        MyText.bodyMedium(controller.worldWonders[index].place, fontWeight: 600),
                                        Padding(
                                          padding: MySpacing.top(5.0),
                                          child: MyText('${controller.worldWonders[index].state}, ${controller.worldWonders[index].country}', fontWeight: 600),
                                        )
                                      ]),
                                    ),
                                  ]),
                                );
                              },
                              markerBuilder: (BuildContext context, int index) {
                                final double markerSize = controller.currentSelectedIndex.value == index ? 40 : 25;
                                return MapMarker(
                                  latitude: controller.worldWonders[index].latitude,
                                  longitude: controller.worldWonders[index].longitude,
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.currentSelectedIndex.value != index) {
                                        controller.updateFocalLatLng(false);
                                        controller.tappedMarkerIndex = index;
                                        controller.pageViewController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                                      }
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 250),
                                      height: markerSize,
                                      width: markerSize,
                                      child: FittedBox(
                                        child: Icon(
                                          Icons.location_on,
                                          color: controller.currentSelectedIndex.value == index ? Colors.blue : Colors.red,
                                          size: markerSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: MyContainer(
                          height: controller.cardHeight,
                          padding: MySpacing.bottom(12),
                          color: Colors.transparent,
                          child: PageView.builder(
                            itemCount: controller.worldWonders.length,
                            onPageChanged: controller.handlePageChange,
                            controller: controller.pageViewController,
                            physics: PageScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final WonderDetails item = controller.worldWonders[index];
                              return Transform.scale(
                                scale: index == controller.currentSelectedIndex.value ? 1 : 0.85,
                                child: MyContainer(
                                  onTap: () {
                                    if (controller.currentSelectedIndex.value != index) {
                                      controller.pageViewController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                                    }
                                  },
                                  padding: MySpacing.all(10),
                                  border: Border.all(color: Color.fromRGBO(153, 153, 153, 1), width: 0.5),
                                  borderRadiusAll: 10,
                                  child: Row(children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: MySpacing.only(top: 5, right: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            MyText('${item.place}, ${item.country}', fontWeight: 600, textAlign: TextAlign.start),
                                            MySpacing.height(5),
                                            Expanded(
                                                child: MyText.bodyMedium(
                                              item.description,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: (index == 2 || index == 6) ? 2 : 4,
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      child: Image.asset(
                                        item.imagePath,
                                        height: controller.cardHeight - 10,
                                        width: controller.cardHeight - 10,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  ]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
