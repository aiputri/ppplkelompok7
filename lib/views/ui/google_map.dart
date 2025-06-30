import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sikilap/controller/ui/google_map_controller.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> with SingleTickerProviderStateMixin, UIMixin {
  late GoogleMapPageController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(GoogleMapPageController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder<GoogleMapPageController>(
            init: controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: MySpacing.x(flexSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.titleMedium(
                          "Google Map",
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: 'Maps'),
                            MyBreadcrumbItem(name: 'Google Map', active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(flexSpacing),
                  Padding(
                      padding: MySpacing.x(flexSpacing),
                      child: MyContainer.none(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 600,
                        child: GoogleMap(
                          onMapCreated: controller.onMapCreated,
                          initialCameraPosition: CameraPosition(target: controller.center, zoom: 11.0),
                        ),
                      )),
                ],
              );
            }));
  }
}
