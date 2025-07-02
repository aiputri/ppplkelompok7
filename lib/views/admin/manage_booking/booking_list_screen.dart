import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/admin/manage_booking/booking_list_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/images.dart';
import 'package:sikilap/views/layout/layout.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> with UIMixin {
  BookingListController controller = Get.put(BookingListController());

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
      child: GetBuilder<BookingListController>( // UBAH: Tipe GetBuilder
        init: controller,
        tag: 'admin_booking_list_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Manajemen Pesanan",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Daftar Pesanan', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                // --- UBAH: Tambahkan logika loading ---
                child: controller.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : controller.bookingList.isEmpty
                        ? Center(child: MyText.bodyMedium("Tidak ada data pesanan."))
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 450,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                              mainAxisExtent: 240,
                            ),
                            itemCount: controller.bookingList.length, // UBAH: Gunakan bookingList
                            itemBuilder: (context, index) {
                              final booking = controller.bookingList[index]; // UBAH: Gunakan bookingList
                              Color statusColor = getStatusColor(booking.statusPesanan);

                              return MyCard(
                                shadow: MyShadow(elevation: 0.5),
                                paddingAll: 0,
                                onTap: () => controller.goToBookingDetail(booking.id),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyContainer(
                                      padding: MySpacing.xy(16, 12),
                                      color: statusColor.withAlpha(40),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // --- UBAH: Tampilkan kodePesanan ---
                                          MyText.bodyMedium(booking.kodePesanan, fontWeight: 700, color: statusColor),
                                          MyText.bodyMedium(booking.statusPesanan, fontWeight: 600, color: statusColor),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: MySpacing.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              MyContainer.rounded(
                                                paddingAll: 0,
                                                height: 40,
                                                width: 40,
                                                child: Image.asset(Images.avatars[index % Images.avatars.length], fit: BoxFit.cover),
                                              ),
                                              MySpacing.width(12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    MyText.bodyMedium(booking.namaPelanggan, fontWeight: 600),
                                                    MyText.bodySmall(booking.teleponPelanggan, muted: true),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          MySpacing.height(16),
                                          Divider(height: 1, color: colorScheme.outline.withAlpha(100)),
                                          MySpacing.height(16),
                                          Row(
                                            children: [
                                              Icon(LucideIcons.spray_can, size: 16, color: contentTheme.primary),
                                              MySpacing.width(8),
                                              Expanded(child: MyText.bodySmall(booking.jenisLayanan, overflow: TextOverflow.ellipsis)),
                                            ],
                                          ),
                                          MySpacing.height(8),
                                          Row(
                                            children: [
                                              Icon(LucideIcons.map_pin, size: 16, color: contentTheme.secondary),
                                              MySpacing.width(8),
                                              Expanded(child: MyText.bodySmall(booking.alamatLayanan, overflow: TextOverflow.ellipsis)),
                                            ],
                                          ),
                                          MySpacing.height(8),
                                          Row(
                                            children: [
                                              Icon(LucideIcons.calendar, size: 16, color: contentTheme.secondary),
                                              MySpacing.width(8),
                                              MyText.bodySmall(booking.jadwalLayanan),
                                            ],
                                          ),
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