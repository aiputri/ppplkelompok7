// lib/views/client/room_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stay_place/controller/client/room_detail_controller.dart'; // <-- CONTROLLER CLIENT BARU
import 'package:stay_place/helpers/utils/my_shadow.dart';
import 'package:stay_place/helpers/utils/ui_mixins.dart';
import 'package:stay_place/helpers/widgets/my_breadcrumb.dart';
import 'package:stay_place/helpers/widgets/my_breadcrumb_item.dart';
import 'package:stay_place/helpers/widgets/my_card.dart';
import 'package:stay_place/helpers/widgets/my_flex.dart';
import 'package:stay_place/helpers/widgets/my_flex_item.dart';
import 'package:stay_place/helpers/widgets/my_spacing.dart';
import 'package:stay_place/helpers/widgets/my_text.dart';
import 'package:stay_place/helpers/widgets/responsive.dart';
import 'package:stay_place/views/layout/layout.dart';
import 'package:stay_place/helpers/widgets/my_button.dart';

class RoomDetailScreen extends StatefulWidget {
  const RoomDetailScreen({super.key});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> with UIMixin {
  late final RoomDetailController controller;

  @override
  void initState() {
    super.initState();
    // Ambil data RoomModel yang dikirim dan buat controller
    controller = Get.put(RoomDetailController(Get.arguments));
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<RoomDetailController>(
        init: controller,
        builder: (controller) {
          if (controller.room == null) {
            return Center(child: CircularProgressIndicator());
          }
          // Ambil data kamar dari controller untuk kemudahan akses
          final room = controller.room!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(room.roomType,
                        fontSize: 18, fontWeight: 600), // Judul dinamis
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Home'),
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
                            paddingAll: 0,
                            child: Image.asset(room.image,
                                height: 250, fit: BoxFit.cover))),
                    // Tampilkan gambar dummy atau gambar lain dari kamar jika ada
                    MyFlexItem(
                        sizes: 'lg-4',
                        child: MyCard(
                            paddingAll: 0,
                            child: Image.asset(
                                'assets/images/dummy/room/hotel_room_2.jpg',
                                height: 250,
                                fit: BoxFit.cover))),
                    MyFlexItem(
                        sizes: 'lg-4',
                        child: MyCard(
                            paddingAll: 0,
                            child: Image.asset(
                                'assets/images/dummy/room/hotel_room_3.jpg',
                                height: 250,
                                fit: BoxFit.cover))),

                    MyFlexItem(sizes: 'lg-8', child: masterSuiteRoom()),
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
    final room = controller.room!;
    return MyCard(
      shadow: MyShadow(elevation: 0.2),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium(room.roomType, fontWeight: 600), // Judul dinamis
          MySpacing.height(16),
          MyText.labelMedium("Bed Type: ${room.bedType}"),
          MySpacing.height(8),
          MyText.labelMedium("Capacity: ${room.capacity} Guests"),
          MySpacing.height(8),
          MyText.labelMedium("Floor: ${room.floor}"),
          MySpacing.height(16),
          MyText.labelMedium("Amenities: ${room.amenities.join(', ')}"),
        ],
      ),
    );
  }

  Widget price() {
    final room = controller.room!;
    return MyCard(
      shadow: MyShadow(elevation: 0.2),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Price", fontWeight: 600),
          MySpacing.height(12),
          Row(
            children: [
              MyText.titleLarge("\$${room.pricePerNight}",
                  fontWeight: 600, color: contentTheme.primary),
              MySpacing.width(4),
              MyText.bodyMedium("per night", color: contentTheme.primary),
            ],
          ),
          MySpacing.height(24),
          MyButton.rounded(
            onPressed: controller
                .goToBookingForm, // <-- PANGGIL FUNGSI DARI CONTROLLER
            elevation: 0,
            padding: MySpacing.xy(20, 16),
            backgroundColor: contentTheme.primary,
            child: MyText.bodyMedium("Book This Room",
                fontWeight: 600, color: contentTheme.onPrimary),
          )
        ],
      ),
    );
  }
}
