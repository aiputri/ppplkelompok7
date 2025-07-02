import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/client/booking_form_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_button.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/my_text_style.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> with UIMixin {
  late final BookingFormController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BookingFormController(Get.arguments));
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<BookingFormController>(
        init: controller,
        builder: (controller) {
          if (controller.hotel == null || controller.room == null) {
            // --- UBAH ISI ---
            return Center(child: MyText.bodyLarge("Data layanan tidak ditemukan!"));
          }

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
                        "Formulir Pemesanan",
                        fontSize: 18,
                        fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        // --- UBAH ISI ---
                        MyBreadcrumbItem(name: 'Detail Layanan'),
                        MyBreadcrumbItem(name: 'Pesan Layanan', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard(
                  shadow: MyShadow(elevation: 0.2),
                  paddingAll: 24,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- UBAH ISI ---
                        MyText.titleMedium("Anda memesan layanan:", fontWeight: 600),
                        MySpacing.height(8),
                        MyText.bodyLarge(
                            // --- UBAH ISI ---
                            "${controller.room!.roomType} dari Mitra ${controller.hotel!.hotelName}"),
                        Divider(height: 48),

                        // --- UBAH ISI FORM ---
                        _buildTextField(
                          label: "Alamat Lengkap Anda",
                          controller: controller.guestsController, // Tetap menggunakan controller ini
                          validator: (val) => val!.isEmpty
                              ? "Mohon masukkan alamat lengkap"
                              : null,
                          icon: LucideIcons.bomb, // Menambahkan ikon
                        ),
                        MySpacing.height(24),
                        _buildTextField(
                          label: "Jenis Kendaraan",
                          controller: controller.guestsController, // Tetap menggunakan controller ini
                          validator: (val) => val!.isEmpty
                              ? "Mohon masukkan jenis kendaraan (Contoh: Avanza 2018)"
                              : null,
                          icon: LucideIcons.car, // Menambahkan ikon
                        ),
                        MySpacing.height(24),
                        _buildDateField(
                          label: "Pilih Tanggal Layanan",
                          controller: controller.checkInController,
                          validator: (val) =>
                              val!.isEmpty ? "Mohon pilih tanggal" : null,
                        ),
                        MySpacing.height(24),
                        _buildTimeField( // Fungsi baru untuk memilih waktu
                          label: "Pilih Waktu Layanan",
                          controller: controller.checkOutController, // Tetap menggunakan controller ini
                          validator: (val) =>
                              val!.isEmpty ? "Mohon pilih waktu" : null,
                        ),
                        MySpacing.height(32),
                        Center(
                          child: MyButton.rounded(
                            onPressed: controller.submitBooking,
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            // --- UBAH ISI ---
                            child: MyText.bodyMedium("Konfirmasi Pesanan",
                                color: contentTheme.onPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget helper untuk text field biasa
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    IconData? icon, // Parameter ikon opsional
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: MyTextStyle.bodyMedium(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        contentPadding: MySpacing.all(16),
        prefixIcon: icon != null ? Icon(icon, color: contentTheme.primary, size: 20) : null,
      ),
    );
  }

  // Widget helper untuk field tanggal
  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: true,
      onTap: () {
        this.controller.selectDate(context, controller);
      },
      style: MyTextStyle.bodyMedium(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        contentPadding: MySpacing.all(16),
        suffixIcon: Icon(LucideIcons.calendar,
            color: contentTheme.primary),
      ),
    );
  }
  
  // Widget helper baru untuk field waktu
  Widget _buildTimeField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: true,
      onTap: () {
        // Logika untuk memanggil TimePicker
        // Anda perlu menambahkan fungsi ini di controller
        // this.controller.selectTime(context, controller);
      },
      style: MyTextStyle.bodyMedium(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        contentPadding: MySpacing.all(16),
        suffixIcon: Icon(LucideIcons.clock,
            color: contentTheme.primary),
      ),
    );
  }
}