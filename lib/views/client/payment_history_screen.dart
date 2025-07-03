// lib/views/client/payment_history_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen>
    with UIMixin {
  final PaymentHistoryController controller =
      Get.put(PaymentHistoryController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<PaymentHistoryController>(
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
                    MyText.titleMedium("Riwayat Pembayaran",
                        fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Akun Saya'),
                        MyBreadcrumbItem(
                            name: 'Riwayat Pembayaran', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard(
                  shadow: MyShadow(
                      elevation: 0.2, position: MyShadowPosition.bottom),
                  paddingAll: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium("Semua Transaksi Anda",
                          fontWeight: 600),
                      MySpacing.height(24),
                      if (controller.isLoading)
                        Center(child: CircularProgressIndicator())
                      else if (controller.paymentHistory.isEmpty)
                        Center(
                            child: MyText.bodyLarge(
                                "Tidak ada riwayat pembayaran."))
                      else
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(
                                  label: MyText.bodySmall('ID Transaksi',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodySmall('Kode Pesanan',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodySmall('Jumlah (Rp)',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodySmall('Metode',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodySmall('Tanggal',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodySmall('Catatan',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodySmall('Status',
                                      fontWeight: 600)),
                            ],
                            // ========== SEMUA PERBAIKAN ADA DI SINI ==========
                            rows: controller.paymentHistory
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        DataCell(MyText.labelSmall(
                                            data.idTransaksi)),
                                        DataCell(MyText.labelSmall(
                                            data.kodePesanan)),
                                        DataCell(MyText.labelSmall(
                                            "Rp ${NumberFormat.decimalPattern('id').format(data.jumlahDibayar)}")),
                                        DataCell(MyText.labelSmall(
                                            data.metodePembayaran)),
                                        DataCell(MyText.labelSmall(
                                            Utils.getDateTimeStringFromDateTime(
                                                data.tanggalPembayaran,
                                                showMonthShort: true,
                                                showSecond: false))),
                                        DataCell(SizedBox(
                                            width: 250,
                                            child: MyText.labelSmall(
                                                data.catatan,
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis))),
                                        DataCell(
                                          MyContainer.bordered(
                                            padding: MySpacing.xy(12, 6),
                                            borderRadiusAll: 4,
                                            color: getStatusColor(
                                                    data.statusPembayaran)
                                                .withAlpha(40),
                                            border: Border.all(
                                                color: getStatusColor(
                                                    data.statusPembayaran)),
                                            child: MyText.labelSmall(
                                                data.statusPembayaran,
                                                color: getStatusColor(
                                                    data.statusPembayaran)),
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList(),
                            // ================================================
                          ),
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

  Color getStatusColor(String status) {
    switch (status) {
      case 'Completed':
      case 'Lunas':
        return contentTheme.success;
      case 'Pending':
      case 'Menunggu Verifikasi':
        return contentTheme.warning;
      case 'Refunded':
      case 'Gagal':
        return contentTheme.danger;
      default:
        return contentTheme.secondary;
    }
  }
}
