// lib/views/client/payment_history_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikilap/helpers/services/booking_service.dart';
import 'package:sikilap/helpers/services/payment_service.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/utils/utils.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_button.dart';
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
  final PaymentService paymentService = Get.find();
  final BookingService bookingService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Obx(() {
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
                shadow:
                    MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                paddingAll: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium("Semua Transaksi Anda", fontWeight: 600),
                    MySpacing.height(24),
                    if (paymentService.payments.isEmpty)
                      Center(
                          child:
                              MyText.bodyLarge("Tidak ada riwayat pembayaran."))
                    else
                      // ========== PERBAIKAN UTAMA DI SINI ==========
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: constraints
                                  .maxWidth, // Memaksa tabel memenuhi lebar
                              child: DataTable(
                                columnSpacing: 16, // Atur jarak antar kolom
                                columns: [
                                  DataColumn(
                                      label: MyText.bodySmall('Detail Pesanan',
                                          fontWeight: 600)),
                                  DataColumn(
                                      label: MyText.bodySmall('Jumlah',
                                          fontWeight: 600),
                                      numeric: true),
                                  DataColumn(
                                      label: MyText.bodySmall('Tanggal',
                                          fontWeight: 600)),
                                  DataColumn(
                                      label: MyText.bodySmall('Status',
                                          fontWeight: 600)),
                                  DataColumn(
                                      label: MyText.bodySmall('Aksi',
                                          fontWeight: 600)),
                                ],
                                rows: paymentService.payments
                                    .mapIndexed((index, data) => DataRow(
                                          cells: [
                                            // Sel 1: Detail Pesanan
                                            DataCell(SizedBox(
                                              width: constraints.maxWidth *
                                                  0.35, // Alokasikan 35% lebar
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  MyText.labelMedium(
                                                      data.catatan,
                                                      fontWeight: 600,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  MyText.labelSmall(
                                                      "ID: ${data.idTransaksi}",
                                                      muted: true),
                                                ],
                                              ),
                                            )),
                                            // Sel 2: Jumlah
                                            DataCell(MyText.labelMedium(
                                                "Rp ${NumberFormat.decimalPattern('id').format(data.jumlahDibayar)}")),
                                            // Sel 3: Tanggal
                                            DataCell(MyText.labelSmall(Utils
                                                .getDateTimeStringFromDateTime(
                                                    data.tanggalPembayaran,
                                                    showMonthShort: true,
                                                    showSecond: false))),
                                            // Sel 4: Status
                                            DataCell(
                                              MyContainer.bordered(
                                                padding: MySpacing.xy(12, 6),
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
                                            // Sel 5: Tombol Aksi
                                            DataCell(
                                              data.statusPembayaran ==
                                                      'Belum Lunas'
                                                  ? MyButton.small(
                                                      onPressed: () {
                                                        showPaymentConfirmation(
                                                            data.kodePesanan);
                                                      },
                                                      elevation: 0,
                                                      backgroundColor:
                                                          contentTheme.primary,
                                                      child: MyText.labelSmall(
                                                          "Bayar",
                                                          color: contentTheme
                                                              .onPrimary),
                                                    )
                                                  : MyText.labelSmall("-",
                                                      muted: true),
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    // ============================================
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  void showPaymentConfirmation(String bookingId) {
    Get.dialog(AlertDialog(
      title: Text("Konfirmasi Pembayaran"),
      content: Text(
          "Anda akan melakukan pembayaran untuk pesanan $bookingId. Lanjutkan?"),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("Batal")),
        TextButton(
          onPressed: () {
            Get.back();
            paymentService.markAsPaid(bookingId, 'Transfer Bank');
            bookingService.confirmBookingStatus(bookingId);
            Get.snackbar(
                "Berhasil", "Pembayaran sedang diverifikasi oleh admin.",
                snackPosition: SnackPosition.BOTTOM);
          },
          child: Text("Lanjutkan"),
        ),
      ],
    ));
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Lunas':
        return contentTheme.success;
      case 'Belum Lunas':
        return contentTheme.warning;
      case 'Gagal':
        return contentTheme.danger;
      default:
        return contentTheme.secondary;
    }
  }
}
