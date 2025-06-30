import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/admin/guest/guest_list_controller.dart';
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
import 'package:sikilap/images.dart';
import 'package:sikilap/views/layout/layout.dart';

class GuestListScreen extends StatefulWidget {
  const GuestListScreen({super.key});

  @override
  State<GuestListScreen> createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> with UIMixin {
  GuestListController controller = Get.put(GuestListController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'guest_list_controller',
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
                      "List Mitra",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'List Mitra', active: true),
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
                      MyText.bodyMedium("Mitra Terdaftar", fontWeight: 600),
                      MySpacing.height(24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            sortAscending: true,
                            onSelectAll: (_) => {},
                            dataRowMaxHeight: 60,
                            columnSpacing: 62,
                            showBottomBorder: false,
                            showCheckboxColumn: true,
                            border: TableBorder.all(style: BorderStyle.solid, width: .4, color: Colors.grey),
                            // Kolom sudah sesuai dengan yang Anda minta
                            columns: [
                              DataColumn(label: MyText.bodySmall('Nama Mitra', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Nomor Telepon', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Area Layanan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Rating', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Status', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Tanggal Gabung', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Aksi', fontWeight: 600)),
                            ],
                            // -- BAGIAN INI DIUBAH UNTUK MENAMPILKAN DATA MITRA --
                            rows: controller.guest // TETAP MENGGUNAKAN 'guest'
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        // Sel 1: Nama Mitra
                                        DataCell(
                                          Row(
                                            children: [
                                              MyContainer.rounded(
                                                height: 32,
                                                width: 32,
                                                paddingAll: 0,
                                                child: Image.asset(
                                                  Images.avatars[index % Images.avatars.length],
                                                ),
                                              ),
                                              MySpacing.width(12),
                                              MyText.labelSmall(data.nama_mitra),
                                            ],
                                          ),
                                        ),
                                        // Sel 2: Nomor Telepon
                                        DataCell(
                                          MyText.labelSmall(data.nomor_telepon),
                                        ),
                                        // Sel 3: Area Layanan
                                        DataCell(
                                          MyText.labelSmall(data.area_layanan),
                                        ),
                                        // Sel 4: Rating
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.star, color: Color(0xffFFC233), size: 16),
                                              MySpacing.width(4),
                                              MyText.labelSmall("${data.rating}"),
                                            ],
                                          ),
                                        ),
                                        // Sel 5: Status
                                        DataCell(
                                          MyContainer.bordered(
                                            padding: MySpacing.xy(12, 6),
                                            borderRadiusAll: 4,
                                            color: data.status == 'Aktif' 
                                                ? contentTheme.success.withAlpha(40) 
                                                : contentTheme.danger.withAlpha(40),
                                            border: Border.all(
                                              color: data.status == 'Aktif' 
                                                  ? contentTheme.success 
                                                  : contentTheme.danger
                                            ),
                                            child: MyText.labelSmall(
                                              data.status,
                                              color: data.status == 'Aktif' 
                                                  ? contentTheme.success 
                                                  : contentTheme.danger,
                                            ),
                                          ),
                                        ),
                                        // Sel 6: Tanggal Gabung
                                        DataCell(
                                          MyText.labelSmall(data.tanggal_gabung),
                                        ),
                                        // Sel 7: Aksi
                                        DataCell(Row(
                                          children: [
                                            MyContainer.rounded(
                                                paddingAll: 8,
                                                onTap: () => controller.editGuest(data.id),
                                                color: contentTheme.primary.withAlpha(40),
                                                child: Icon(LucideIcons.pencil, size: 14, color: contentTheme.primary)),
                                            MySpacing.width(8),
                                            MyContainer.rounded(
                                                paddingAll: 8,
                                                onTap: () => controller.addGuest(data.id), // Anda mungkin ingin ganti ini ke deleteGuest
                                                color: contentTheme.danger.withAlpha(40),
                                                child: Icon(LucideIcons.trash_2, size: 14, color: contentTheme.danger)),
                                          ],
                                        ))
                                      ],
                                    ))
                                .toList()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}