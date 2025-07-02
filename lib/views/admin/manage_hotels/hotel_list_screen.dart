import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/admin/manage_hotels/hotel_list_controller.dart';
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

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> with UIMixin {
  HotelListController controller = Get.put(HotelListController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'hotel_list_controller',
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
                      // --- UBAH ISI ---
                      "Manajemen Mitra",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        // --- UBAH ISI ---
                        MyBreadcrumbItem(name: 'Daftar Mitra', active: true),
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
                          MyText.bodyMedium("Daftar Mitra Terdaftar"),
                          MyContainer(
                            paddingAll: 8,
                            onTap: controller.addHotel,
                            color: contentTheme.primary,
                            // --- UBAH ISI ---
                            child: MyText.labelSmall("Tambah Mitra Baru", color: contentTheme.onPrimary),
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
                              DataColumn(label: MyText.bodySmall('Nama Mitra', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Area Layanan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Nama Pemilik', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Email', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('No. Telepon', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Aksi', fontWeight: 600)),
                            ],
                            rows: controller.hotel
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        DataCell(Row(
                                          children: [
                                            MyContainer(
                                              paddingAll: 0,
                                              height: 48,
                                              width: 48,
                                              child: Image.asset(data.image),
                                            ),
                                            MySpacing.width(24),
                                            MyText.labelSmall(data.hotelName),
                                          ],
                                        )),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.map_pin, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.cityName),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.user, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.ownerName),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.mail, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.email),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.phone, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.phoneNumber),
                                            ],
                                          ),
                                        ),
                                        DataCell(Row(
                                          children: [
                                            MyContainer.rounded(
                                                paddingAll: 12,
                                                onTap: controller.editHotel,
                                                color: contentTheme.primary.withValues(alpha: .5),
                                                splashColor: contentTheme.background,
                                                borderRadiusAll: 100,
                                                child: Icon(LucideIcons.pencil, size: 12, color: contentTheme.primary)),
                                            MySpacing.width(8),
                                            MyContainer.rounded(
                                                paddingAll: 12,
                                                onTap: controller.viewDetail,
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