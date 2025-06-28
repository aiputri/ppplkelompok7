// lib/views/client/booking_form_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stay_place/controller/client/booking_form_controller.dart';
import 'package:stay_place/helpers/utils/my_shadow.dart';
import 'package:stay_place/helpers/utils/ui_mixins.dart';
import 'package:stay_place/helpers/widgets/my_breadcrumb.dart';
import 'package:stay_place/helpers/widgets/my_breadcrumb_item.dart';
import 'package:stay_place/helpers/widgets/my_button.dart';
import 'package:stay_place/helpers/widgets/my_card.dart';
import 'package:stay_place/helpers/widgets/my_spacing.dart';
import 'package:stay_place/helpers/widgets/my_text.dart';
import 'package:stay_place/helpers/widgets/my_text_style.dart';
import 'package:stay_place/helpers/widgets/responsive.dart';
import 'package:stay_place/views/layout/layout.dart';
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
            return Center(child: MyText.bodyLarge("Booking data not found!"));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Booking Form",
                        fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Room Detail'),
                        MyBreadcrumbItem(name: 'Booking', active: true),
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
                        MyText.titleMedium("You are booking:", fontWeight: 600),
                        MySpacing.height(8),
                        MyText.bodyLarge(
                            "${controller.room!.roomType} at ${controller.hotel!.hotelName}"),
                        Divider(height: 48),

                        // ========== PERUBAHAN DI SINI ==========
                        _buildDateField(
                          label: "Check-in Date",
                          controller: controller.checkInController,
                          validator: (val) =>
                              val!.isEmpty ? "Please select a date" : null,
                        ),
                        MySpacing.height(24),
                        _buildDateField(
                          label: "Check-out Date",
                          controller: controller.checkOutController,
                          validator: (val) =>
                              val!.isEmpty ? "Please select a date" : null,
                        ),
                        // ======================================

                        MySpacing.height(24),
                        _buildTextField(
                          label: "Number of Guests",
                          controller: controller.guestsController,
                          validator: (val) => val!.isEmpty
                              ? "Please enter number of guests"
                              : null,
                        ),
                        MySpacing.height(32),
                        Center(
                          child: MyButton.rounded(
                            onPressed: controller.submitBooking,
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            child: MyText.bodyMedium("Confirm Booking",
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
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: MyTextStyle.bodyMedium(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        contentPadding: MySpacing.all(16),
      ),
    );
  }

  // Widget helper baru untuk text field tanggal
  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: true, // Membuat field tidak bisa diketik manual
      onTap: () {
        // Memanggil fungsi selectDate dari controller saat di-klik
        this.controller.selectDate(context, controller);
      },
      style: MyTextStyle.bodyMedium(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        contentPadding: MySpacing.all(16),
        suffixIcon: Icon(LucideIcons.calendar,
            color: contentTheme.primary), // Menambahkan ikon kalender
      ),
    );
  }
}
