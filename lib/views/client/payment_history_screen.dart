// lib/views/client/payment_history_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import intl untuk format angka
import 'package:sikilap/controller/client/payment_history_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/utils/utils.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_list_extension.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> with UIMixin {
  PaymentHistoryController controller = Get.put(PaymentHistoryController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'payment_history_controller',
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
                      "Riwayat Pembayaran",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Akun Saya'),
                        // --- UBAH ISI ---
                        MyBreadcrumbItem(name: 'Riwayat Pembayaran', active: true),
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
                      MyText.bodyMedium("Semua Transaksi Anda", fontWeight: 600),
                      MySpacing.height(24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            sortAscending: true,
                            onSelectAll: (_) => {},
                            dataRowMaxHeight: 60,
                            columnSpacing: 55,
                            showBottomBorder: false,
                            showCheckboxColumn: false, // Pelanggan tidak perlu memilih
                            border: TableBorder.all(style: BorderStyle.solid, width: .4, color: Colors.grey),
                            // --- UBAH ISI KOLOM (LEBIH SEDERHANA) ---
                            columns: [
                              DataColumn(label: MyText.bodySmall('ID Transaksi', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Kode Pesanan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Jumlah (Rp)', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Metode', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Tanggal', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Catatan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Status', fontWeight: 600)),
                            ],
                            // Data akan dipetakan sesuai model yang sudah ada
                            rows: controller.paymentHistory
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        // Sel 1: ID Transaksi
                                        DataCell(MyText.labelSmall(data.transactionID)),
                                        // Sel 2: Kode Pesanan
                                        DataCell(MyText.labelSmall(data.bookingID)),
                                        // Sel 3: Jumlah Pembayaran (format Rupiah)
                                        DataCell(MyText.labelSmall("Rp ${NumberFormat.decimalPattern('id').format(data.amountPaid)}")),
                                        // Sel 4: Metode Pembayaran
                                        DataCell(MyText.labelSmall(data.paymentMethod)),
                                        // Sel 5: Tanggal Pembayaran
                                        DataCell(
                                            MyText.labelSmall(Utils.getDateTimeStringFromDateTime(data.paymentDate, showMonthShort: true, showSecond: false))),
                                        // Sel 6: Catatan
                                        DataCell(SizedBox(width: 250, child: MyText.labelSmall(data.paymentNote, maxLines: 2, overflow: TextOverflow.ellipsis))),
                                        // Sel 7: Status Pembayaran (dengan badge)
                                        DataCell(
                                          MyContainer.bordered(
                                            padding: MySpacing.xy(12, 6),
                                            borderRadiusAll: 4,
                                            color: getStatusColor(data.paymentStatus).withAlpha(40),
                                            border: Border.all(color: getStatusColor(data.paymentStatus)),
                                            child: MyText.labelSmall(
                                              data.paymentStatus,
                                              color: getStatusColor(data.paymentStatus),
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
      case 'Completed':
      case 'Lunas': // Menambahkan alias
        return contentTheme.success;
      case 'Pending':
      case 'Menunggu Verifikasi': // Menambahkan alias
        return contentTheme.warning;
      case 'Refunded':
      case 'Gagal': // Menambahkan alias
        return contentTheme.danger;
      default:
        return contentTheme.secondary;
    }
  }
}