import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/admin/manage_room/room_detail_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_flex.dart';
import 'package:sikilap/helpers/widgets/my_flex_item.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';

class RoomDetailScreen extends StatefulWidget {
  const RoomDetailScreen({super.key});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> with UIMixin {
  RoomDetailController controller = Get.put(RoomDetailController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'room_detail_controller',
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
                      "Room Detail",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Room Detail', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                        sizes: 'lg-4',
                        child: MyCard(
                            shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                            paddingAll: 24,
                            child: Image.asset('assets/images/dummy/room/hotel_room_1.jpg', height: 250, fit: BoxFit.cover))),
                    MyFlexItem(
                        sizes: 'lg-4',
                        child: MyCard(
                            shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                            paddingAll: 24,
                            child: Image.asset('assets/images/dummy/room/hotel_room_2.jpg', height: 250, fit: BoxFit.cover))),
                    MyFlexItem(
                        sizes: 'lg-4',
                        child: MyCard(
                            shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                            paddingAll: 24,
                            child: Image.asset('assets/images/dummy/room/hotel_room_3.jpg', height: 250, fit: BoxFit.cover))),
                    MyFlexItem(
                        sizes: 'lg-8',
                        child: Column(
                          children: [masterSuiteRoom(), MySpacing.height(24), amenitiesRoom()],
                        )),
                    MyFlexItem(sizes: 'lg-4', child: price()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget masterSuiteRoom() {
    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Master Suite Room", fontWeight: 600),
          MySpacing.height(24),
          MyText.labelMedium(controller.dummyTexts[0]),
          MySpacing.height(24),
          MyText.labelMedium(controller.dummyTexts[1]),
          MySpacing.height(24),
          MyText.labelMedium(controller.dummyTexts[2]),
          MyText.labelMedium(controller.dummyTexts[3]),
          MyText.labelMedium(controller.dummyTexts[4]),
        ],
      ),
    );
  }

  Widget amenitiesRoom() {
    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Aminitiese Room", fontWeight: 600),
          MySpacing.height(24),
          MyText.labelMedium(controller.dummyTexts[3]),
          MySpacing.height(24),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: controller.amenities.map((e) {
              return MyContainer.bordered(
                child: Column(
                  children: [
                    Icon(e['icon'], size: 20),
                    MySpacing.height(8),
                    MyText.bodySmall(e['name'], fontWeight: 600),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget price() {
    Widget facility(String title) {
      return Row(
        children: [
          MyContainer.rounded(paddingAll: 3, color: contentTheme.dark),
          MySpacing.width(8),
          MyText.bodyMedium(title),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Price", fontWeight: 600),
          MySpacing.height(12),
          Row(
            children: [
              MyText.titleLarge("\$120.00", fontWeight: 600, color: contentTheme.primary),
              MySpacing.width(4),
              MyText.bodyMedium("per night", color: contentTheme.primary),
            ],
          ),
          MySpacing.height(16),
          MyText.bodyMedium("Hotel facilities", fontWeight: 600),
          MySpacing.height(24),
          facility("Buffet breakfast as per the Itinerary"),
          MySpacing.height(16),
          facility("Visit eight villages showcasing Polynesian culture"),
          MySpacing.height(16),
          facility("Complimentary Camel safari, Bonfire,"),
          MySpacing.height(16),
          facility("All toll tax, parking, fuel, and driver allowances"),
          MySpacing.height(16),
          facility("Comfortable and hygienic vehicle"),
          MySpacing.height(24),
          MyContainer(
            paddingAll: 12,
            color: contentTheme.primary,
            child: MyText.bodyMedium("Book Now", fontWeight: 600, color: contentTheme.onPrimary),
          )
        ],
      ),
    );
  }
}
