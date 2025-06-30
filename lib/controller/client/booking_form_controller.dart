// lib/controller/client/booking_form_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/hotel_model.dart';
import 'package:sikilap/model/room_model.dart';
import 'package:intl/intl.dart';

class BookingFormController extends MyController {
  final HotelModel? hotel;
  final RoomModel? room;

  // Form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController checkInController;
  late TextEditingController checkOutController;
  late TextEditingController guestsController;

  BookingFormController(Map<String, dynamic> bookingData)
      : hotel = bookingData['hotel'],
        room = bookingData['room'];

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:
          DateTime.now(), // Pengguna tidak bisa memilih tanggal di masa lalu
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      // Format tanggal menjadi string yang mudah dibaca (contoh: '2023-10-27')
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      controller.text = formattedDate;
      update(); // Update UI jika perlu
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkInController = TextEditingController();
    checkOutController = TextEditingController();
    guestsController = TextEditingController(text: '1');
  }

  void submitBooking() {
    if (formKey.currentState!.validate()) {
      // Logika untuk menyimpan booking
      Get.dialog(AlertDialog(
        title: Text("Booking Submitted!"),
        content: Text(
            "Your booking for ${room!.roomType} at ${hotel!.hotelName} has been received."),
        actions: [
          TextButton(
            onPressed: () => Get.offAllNamed('/home'),
            child: Text("Go to Home"),
          )
        ],
      ));
    }
  }

  @override
  void onClose() {
    checkInController.dispose();
    checkOutController.dispose();
    guestsController.dispose();
    super.onClose();
  }
}
