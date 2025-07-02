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

  // Fungsi untuk mendapatkan warna status
  Color getStatusColor(String status) {
    switch (status) {
      case 'Aktif':
        return contentTheme.success;
      case 'Nonaktif':
        return contentTheme.secondary;
      case 'Diblokir':
        return contentTheme.danger;
      default:
        return contentTheme.warning;
    }
  }

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
                      // --- UBAH ISI ---
                      "Daftar Pelanggan",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        // --- UBAH ISI ---
                        MyBreadcrumbItem(name: 'Pelanggan', active: true),
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
                      // --- UBAH ISI ---
                      MyText.bodyMedium("Pelanggan Terdaftar", fontWeight: 600),
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
                            // --- UBAH ISI KOLOM ---
                            columns: [
                              DataColumn(label: MyText.bodySmall('Nama Pelanggan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Email', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Nomor Telepon', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Total Pesanan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Tanggal Bergabung', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Status', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Aksi', fontWeight: 600)),
                            ],
                            // Data akan dipetakan sesuai field yang ada di model
                            rows: controller.guest
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        // Sel 1: Nama Pelanggan
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
                                              MyText.labelSmall(data.nama_pelanggan),
                                            ],
                                          ),
                                        ),
                                        // Sel 2: Email
                                        DataCell(
                                          MyText.labelSmall(data.email),
                                        ),
                                        // Sel 3: Nomor Telepon
                                        DataCell(
                                          MyText.labelSmall(data.nomor_telepon),
                                        ),
                                        // Sel 4: Jumlah Pesanan
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.shopping_cart, size: 16),
                                              MySpacing.width(4),
                                              MyText.labelSmall("${data.jumlah_pesanan}x"),
                                            ],
                                          ),
                                        ),
                                        // Sel 5: Tanggal Bergabung
                                        DataCell(
                                          MyText.labelSmall(data.tanggal_bergabung),
                                        ),
                                        // Sel 6: Status
                                        DataCell(
                                          MyContainer.bordered(
                                            padding: MySpacing.xy(12, 6),
                                            borderRadiusAll: 4,
                                            color: getStatusColor(data.status).withAlpha(40),
                                            border: Border.all(
                                              color: getStatusColor(data.status),
                                            ),
                                            child: MyText.labelSmall(
                                              data.status,
                                              color: getStatusColor(data.status),
                                            ),
                                          ),
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
                                                child: Icon(LucideIcons.user_x, size: 14, color: contentTheme.danger)),
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