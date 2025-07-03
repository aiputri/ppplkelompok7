// lib/views/client/my_booking_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/client/my_booking_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart'; // Diperlukan untuk badge
import 'package:sikilap/helpers/widgets/my_list_extension.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> with UIMixin {
  MyBookingController controller = Get.put(MyBookingController());

  // Fungsi untuk mendapatkan warna status
  Color getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return contentTheme.success;
      case 'Dikonfirmasi':
      case 'Dikerjakan':
        return contentTheme.primary;
      case 'Menunggu Konfirmasi':
        return contentTheme.warning;
      case 'Dibatalkan':
        return contentTheme.danger;
      default:
        return contentTheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Obx(
        () {
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
                      "Pesanan Saya",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Akun Saya'),
                        // --- UBAH ISI ---
                        MyBreadcrumbItem(name: 'Pesanan Saya', active: true),
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
                      // --- UBAH ISI ---
                      MyText.bodyMedium("Riwayat dan Status Pesanan",
                          fontWeight: 600),
                      MySpacing.height(24),
                      if (controller.myBooking.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              sortAscending: true,
                              onSelectAll: (_) => {},
                              dataRowMaxHeight: 60,
                              columnSpacing: 55, // Disesuaikan
                              showBottomBorder: false,
                              showCheckboxColumn: false, // Tidak perlu checkbox
                              border: TableBorder.all(
                                  style: BorderStyle.solid,
                                  width: .4,
                                  color: Colors.grey),
                              // --- UBAH ISI KOLOM (LEBIH SEDERHANA) ---
                              columns: [
                                DataColumn(
                                    label: MyText.bodySmall('ID Pesanan',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Nama Mitra',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Layanan',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Jadwal Layanan',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Total Biaya (Rp)',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Metode Pembayaran',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Status Pesanan',
                                        fontWeight: 600)),
                              ],
                              rows: controller.myBooking
                                  .mapIndexed((index, data) => DataRow(
                                        cells: [
                                          // Data disesuaikan dengan model 'MyBooking'
                                          DataCell(MyText.labelSmall(
                                              data.bookingID)),
                                          DataCell(MyText.labelSmall(
                                              data.hotelName)),
                                          DataCell(
                                              MyText.labelSmall(data.roomType)),
                                          DataCell(MyText.labelSmall(
                                              data.checkInDate)),
                                          DataCell(MyText.labelSmall(
                                              '${data.totalPrice.toInt()}')),
                                          DataCell(MyText.labelSmall(
                                              data.paymentMethod)),
                                          DataCell(
                                            // Menggunakan badge untuk status
                                            MyContainer.bordered(
                                              padding: MySpacing.xy(12, 6),
                                              borderRadiusAll: 4,
                                              color: getStatusColor(
                                                      data.bookingStatus)
                                                  .withAlpha(40),
                                              border: Border.all(
                                                  color: getStatusColor(
                                                      data.bookingStatus)),
                                              child: MyText.labelSmall(
                                                data.bookingStatus,
                                                color: getStatusColor(
                                                    data.bookingStatus),
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
}
