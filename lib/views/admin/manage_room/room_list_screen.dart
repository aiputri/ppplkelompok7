import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/admin/manage_room/room_list_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_list_extension.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> with UIMixin {
  RoomListController controller = Get.put(RoomListController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'room_list_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      // --- UBAH ISI ---
                      "Daftar Layanan",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        // --- UBAH ISI ---
                        MyBreadcrumbItem(name: 'Layanan', active: true),
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
                  paddingAll: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // --- UBAH ISI ---
                          MyText.bodyMedium("Layanan yang Tersedia"),
                          MyContainer(
                            paddingAll: 8,
                            onTap: controller.gotoAddRoom,
                            color: contentTheme.primary,
                            // --- UBAH ISI ---
                            child: MyText.labelSmall("Tambah Layanan Baru", color: contentTheme.onPrimary),
                          )
                        ],
                      ),
                      MySpacing.height(24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            sortAscending: true,
                            onSelectAll: (_) => {},
                            dataRowMaxHeight: 60,
                            columnSpacing: 100, // Disesuaikan
                            showBottomBorder: false,
                            showCheckboxColumn: true,
                            border: TableBorder.all(style: BorderStyle.solid, width: .4, color: Colors.grey),
                            // --- UBAH ISI KOLOM ---
                            columns: [
                              DataColumn(label: MyText.bodySmall('Nama Layanan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Kategori', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Jenis Mobil', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Estimasi Waktu', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Harga (Rp)', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Aksi', fontWeight: 600)),
                            ],
                            rows: controller.room
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        // Sel 1: Nama Layanan (dari roomType)
                                        DataCell(Row(
                                          children: [
                                            MyContainer(
                                              paddingAll: 0,
                                              height: 48,
                                              width: 48,
                                              child: Image.asset(data.image),
                                            ),
                                            MySpacing.width(24),
                                            MyText.labelSmall(data.roomType),
                                          ],
                                        )),
                                        // Sel 2: Kategori (dari bedType)
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.shield_check, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.bedType),
                                            ],
                                          ),
                                        ),
                                        // Sel 3: Jenis Mobil (dari view)
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.car, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.view),
                                            ],
                                          ),
                                        ),
                                        // Sel 4: Estimasi Waktu (dari floor)
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.timer, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall("${data.floor} menit"),
                                            ],
                                          ),
                                        ),
                                        // Sel 5: Harga (dari pricePerNight)
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.dollar_sign, size: 16),
                                              MySpacing.width(8),
                                              // --- UBAH ISI ---
                                              MyText.labelSmall("Rp ${data.pricePerNight.toInt()}"),
                                            ],
                                          ),
                                        ),
                                        // Sel 6: Aksi (tombol tetap sama)
                                        DataCell(Row(
                                          children: [
                                            MyContainer.rounded(
                                                paddingAll: 12,
                                                onTap: controller.editRoom,
                                                color: contentTheme.primary.withValues(alpha: .5),
                                                splashColor: contentTheme.background,
                                                borderRadiusAll: 100,
                                                child: Icon(LucideIcons.pencil, size: 12, color: contentTheme.primary)),
                                            MySpacing.width(8),
                                            MyContainer.rounded(
                                                paddingAll: 12,
                                                onTap: controller.roomDetail,
                                                color: contentTheme.secondary.withValues(alpha: .5),
                                                splashColor: contentTheme.background,
                                                borderRadiusAll: 100,
                                                child: Icon(LucideIcons.eye, size: 12, color: contentTheme.secondary)),
                                          ],
                                        ))
                                      ],
                                    ))
                                .toList()),
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