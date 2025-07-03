// lib/controller/client/booking_form_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikilap/controller/my_controller.dart';
// Ganti path ini dengan path model yang benar di proyekmu
import 'package:sikilap/model/hotel_model.dart';
import 'package:sikilap/model/room_model.dart';
import 'package:sikilap/helpers/services/booking_service.dart';

class BookingFormController extends MyController {
  // Properti ini sekarang nullable, bisa jadi null jika diakses dari sidebar
  final HotelModel? hotel;
  final RoomModel? room;

  // Form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController checkInController; // Untuk tanggal
  late TextEditingController checkOutController; // Untuk waktu
  late TextEditingController guestsController; // Untuk alamat
  late TextEditingController
      vehicleController; // Controller baru untuk jenis kendaraan
  final BookingService bookingService = Get.find();

  // Constructor yang dimodifikasi untuk menerima argumen yang mungkin null
  BookingFormController(Map<String, dynamic>? bookingData)
      : hotel = bookingData?['hotel'],
        room = bookingData?['room'];

  @override
  void onInit() {
    super.onInit();
    checkInController = TextEditingController();
    checkOutController = TextEditingController();
    guestsController = TextEditingController();
    vehicleController = TextEditingController();
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      controller.text = formattedDate;
      update();
    }
  }

  // Fungsi baru untuk memilih waktu
  Future<void> selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      // Format waktu (misal: 14:30)
      final localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(picked);
      controller.text = formattedTime;
      update();
    }
  }

  void submitBooking() {
    if (formKey.currentState!.validate()) {
      // Panggil service untuk membuat pesanan baru
      bookingService.createNewBooking(
        hotel: hotel!,
        room: room!,
        bookingDate: checkInController.text, // Tanggal
        bookingTime: checkOutController.text, // Waktu
        address: guestsController.text, // Alamat
        vehicleType: vehicleController.text, // Jenis Kendaraan
      );

      // Arahkan ke halaman "Pesanan Saya"
      Get.toNamed('/my_booking');

      // Tampilkan notifikasi sukses
      Get.snackbar(
        "Berhasil!",
        "Pesanan Anda sedang menunggu konfirmasi dari admin.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    checkInController.dispose();
    checkOutController.dispose();
    guestsController.dispose();
    vehicleController.dispose();
    super.onClose();
  }
}
