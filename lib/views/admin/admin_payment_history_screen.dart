// lib/views/admin/riwayat_pembayaran_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import intl untuk format angka
import 'package:sikilap/controller/admin/admin_payment_history_controller.dart'; // Ganti ke controller yang benar
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/utils/utils.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart'; // Diperlukan untuk badge
import 'package:sikilap/helpers/widgets/my_list_extension.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';

class RiwayatPembayaranScreen extends StatefulWidget {
  const RiwayatPembayaranScreen({super.key});

  @override
  State<RiwayatPembayaranScreen> createState() => _RiwayatPembayaranScreenState();
}

class _RiwayatPembayaranScreenState extends State<RiwayatPembayaranScreen> with UIMixin {
  // Ganti ke controller yang sesuai
  RiwayatPembayaranController controller = Get.put(RiwayatPembayaranController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<RiwayatPembayaranController>( // Ganti generic type
        init: controller,
        tag: 'riwayat_pembayaran_controller', // Ganti tag
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
                      "Riwayat Pembayaran",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Pembayaran', active: true),
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
                      MyText.bodyMedium("Semua Transaksi Pembayaran", fontWeight: 600),
                      MySpacing.height(24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            sortAscending: true,
                            onSelectAll: (_) => {},
                            dataRowMaxHeight: 60,
                            columnSpacing: 55,
                            showBottomBorder: false,
                            showCheckboxColumn: true,
                            border: TableBorder.all(style: BorderStyle.solid, width: .4, color: Colors.grey),
                            columns: [
                              DataColumn(label: MyText.bodySmall('ID Transaksi', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Kode Pesanan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Pelanggan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Jumlah (Rp)', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Metode', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Tanggal', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Catatan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Status', fontWeight: 600)),
                            ],
                            rows: controller.riwayatPembayaran // Ganti ke list yang benar
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        DataCell(MyText.labelSmall(data.idTransaksi)),
                                        DataCell(MyText.labelSmall(data.kodePesanan)),
                                        DataCell(MyText.labelSmall(data.namaPelanggan)),
                                        DataCell(MyText.labelSmall(NumberFormat.decimalPattern('id').format(data.jumlahDibayar))),
                                        DataCell(MyText.labelSmall(data.metodePembayaran)),
                                        DataCell(
                                            MyText.labelSmall(Utils.getDateTimeStringFromDateTime(data.tanggalPembayaran, showMonthShort: true, showSecond: false))),
                                        DataCell(SizedBox(width: 250, child: MyText.labelSmall(data.catatan, maxLines: 2, overflow: TextOverflow.ellipsis))),
                                        DataCell(
                                          MyContainer.bordered(
                                            padding: MySpacing.xy(12, 6),
                                            borderRadiusAll: 4,
                                            color: getStatusColor(data.statusPembayaran).withAlpha(40),
                                            border: Border.all(color: getStatusColor(data.statusPembayaran)),
                                            child: MyText.labelSmall(
                                              data.statusPembayaran,
                                              color: getStatusColor(data.statusPembayaran),
                                            ),
                                          ),
                                        ),
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

  // Fungsi helper untuk menentukan warna status badge
  Color getStatusColor(String status) {
    switch (status) {
      case 'Lunas':
        return contentTheme.success;
      case 'Menunggu Verifikasi':
        return contentTheme.warning;
      case 'Gagal':
        return contentTheme.danger;
      default:
        return contentTheme.secondary;
    }
  }
}