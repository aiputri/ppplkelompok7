// lib/views/client/room_selection_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/client/room_selection_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_button.dart'; // <-- IMPORT BARU
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/model/room_model.dart';
import 'package:sikilap/views/layout/layout.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({super.key});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen>
    with UIMixin {
  // Ubah cara inisialisasi controller agar sesuai dengan alur yang benar
  late final RoomSelectionController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(RoomSelectionController(Get.arguments));
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<RoomSelectionController>(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Pilih Layanan",
                        fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Mitra'),
                        MyBreadcrumbItem(name: 'Pilih Layanan', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                // Tampilkan loading atau pesan jika belum ada layanan
                child: controller.rooms.isEmpty
                    ? Center(
                        child: MyText.bodyLarge(
                            "Tidak ada layanan yang tersedia untuk mitra ini."))
                    : GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          mainAxisExtent: 450,
                        ),
                        itemCount: controller.rooms.length,
                        itemBuilder: (context, index) {
                          RoomModel room = controller.rooms[index];
                          return MyCard(
                            shadow: MyShadow(
                                elevation: 0.2,
                                position: MyShadowPosition.bottom),
                            paddingAll: 24,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    MyContainer(
                                      paddingAll: 0,
                                      height: 200,
                                      width: double.infinity,
                                      child: Image.asset(room.image,
                                          fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                      right: 12,
                                      top: 12,
                                      child: MyContainer.rounded(
                                        onTap: () =>
                                            controller.onFavouriteToggle(room),
                                        paddingAll: 12,
                                        child: Icon(
                                            room.isFavourite
                                                ? Icons.favorite_rounded
                                                : Icons
                                                    .favorite_outline_rounded,
                                            size: 16,
                                            color: room.isFavourite
                                                ? contentTheme.danger
                                                : null,
                                            fill: 0),
                                      ),
                                    )
                                  ],
                                ),
                                // ... (Kode Stack untuk gambar tetap sama)
                                MySpacing.height(24),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText.bodyMedium(room.roomType,
                                                fontWeight: 600,
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            MyText.labelMedium(
                                                "Kategori: ${room.bedType}"),
                                            MyText.labelMedium(
                                                "Jenis Mobil: ${room.view}"),
                                            MyText.labelMedium(
                                                "Estimasi: ${room.floor} menit"),
                                            MyText.labelMedium(
                                                "Mulai dari: Rp ${room.pricePerNight.toInt()}"),
                                          ],
                                        ),
                                      ),
                                      // ========== UBAH MyContainer MENJADI MyButton ==========
                                      MyButton(
                                        onPressed: () =>
                                            controller.goToBookingForm(room),
                                        padding: MySpacing.xy(8, 4),
                                        backgroundColor: contentTheme.primary,
                                        elevation: 0,
                                        child: MyText.labelSmall("Pesan",
                                            fontWeight: 600,
                                            color: contentTheme.onPrimary),
                                      ),
                                      // =======================================================
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
