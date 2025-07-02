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

// --- PERUBAHAN 1: Tambahkan TickerProviderStateMixin ---
class _BookingListScreenState extends State<BookingListScreen>
    with UIMixin, TickerProviderStateMixin {
  BookingListController controller = Get.put(BookingListController());

  // Fungsi untuk mendapatkan warna status (tidak diubah)
  Color getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
      case 'Tunda':
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
      child: GetBuilder<BookingListController>(
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
                child: controller.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : controller.bookingList.isEmpty
                        ? Center(
                            child: MyText.bodyMedium("Tidak ada data pesanan."))
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 450,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                              mainAxisExtent: 240,
                            ),
                            itemCount: controller.bookingList.length,
                            itemBuilder: (context, index) {
                              final booking = controller.bookingList[index];
                              Color statusColor =
                                  getStatusColor(booking.statusPesanan);

                              return MyCard(
                                shadow: MyShadow(elevation: 0.5),
                                paddingAll: 0,
                                onTap: () =>
                                    controller.goToBookingDetail(booking.id),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyContainer(
                                      padding: MySpacing.xy(16, 12),
                                      color: statusColor.withAlpha(40),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText.bodyMedium(booking.kodePesanan,
                                              fontWeight: 700,
                                              color: statusColor),
                                          
                                          // --- PERUBAHAN 3: Gunakan BlinkingStatus ---
                                          // Jika statusnya 'Menunggu Konfirmasi', gunakan widget berkelip
                                          if (booking.statusPesanan == 'Menunggu Konfirmasi')
                                            BlinkingStatus(status: booking.statusPesanan, color: statusColor)
                                          else
                                            // Jika tidak, tampilkan teks biasa
                                            MyText.bodyMedium(booking.statusPesanan, fontWeight: 600, color: statusColor),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: MySpacing.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              MyContainer.rounded(
                                                paddingAll: 0,
                                                height: 40,
                                                width: 40,
                                                child: Image.asset(Images
                                                        .avatars[
                                                    index % Images.avatars.length],
                                                    fit: BoxFit.cover),
                                              ),
                                              MySpacing.width(12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    MyText.bodyMedium(
                                                        booking.namaPelanggan,
                                                        fontWeight: 600),
                                                    MyText.bodySmall(
                                                        booking.teleponPelanggan,
                                                        muted: true),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          MySpacing.height(16),
                                          Divider(
                                              height: 1,
                                              color: colorScheme.outline
                                                  .withAlpha(100)),
                                          MySpacing.height(16),
                                          Row(
                                            children: [
                                              Icon(LucideIcons.spray_can,
                                                  size: 16,
                                                  color: contentTheme.primary),
                                              MySpacing.width(8),
                                              Expanded(
                                                  child: MyText.bodySmall(
                                                      booking.jenisLayanan,
                                                      overflow:
                                                          TextOverflow.ellipsis)),
                                            ],
                                          ),
                                          MySpacing.height(8),
                                          Row(
                                            children: [
                                              Icon(LucideIcons.map_pin,
                                                  size: 16,
                                                  color:
                                                      contentTheme.secondary),
                                              MySpacing.width(8),
                                              Expanded(
                                                  child: MyText.bodySmall(
                                                      booking.alamatLayanan,
                                                      overflow:
                                                          TextOverflow.ellipsis)),
                                            ],
                                          ),
                                          MySpacing.height(8),
                                          Row(
                                            children: [
                                              Icon(LucideIcons.calendar,
                                                  size: 16,
                                                  color:
                                                      contentTheme.secondary),
                                              MySpacing.width(8),
                                              MyText.bodySmall(
                                                  booking.jadwalLayanan),
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

// --- PERUBAHAN 2: Tambahkan Widget BlinkingStatus di sini ---
class BlinkingStatus extends StatefulWidget {
  final String status;
  final Color color;

  const BlinkingStatus({Key? key, required this.status, required this.color}) : super(key: key);

  @override
  _BlinkingStatusState createState() => _BlinkingStatusState();
}

class _BlinkingStatusState extends State<BlinkingStatus> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: MyText.bodyMedium(
        widget.status,
        fontWeight: 600,
        color: widget.color,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}