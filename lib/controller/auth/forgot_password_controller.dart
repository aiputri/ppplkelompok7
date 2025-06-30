// lib/controller/auth/forgot_password_controller.dart

import 'package:flutter/material.dart';
// import 'package:sikilap/helpers/services/auth_services.dart'; // Kita tidak butuh ini lagi di sini
import 'package:sikilap/helpers/widgets/my_form_validator.dart';
import 'package:sikilap/helpers/widgets/my_validators.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';

class ForgotPasswordController extends MyController {
  var greeting = "Good Morning";
  late int currentTime = DateTime.now().hour;

  MyFormValidator basicValidator = MyFormValidator();
  bool showPassword = false;

  @override
  void onInit() {
    super.onInit(); // Panggil super.onInit() di awal
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(text: "demo@example.com"),
    );

    if ((currentTime < 6) || (currentTime > 21)) {
      greeting = 'Good Night';
    } else if (currentTime < 12) {
      greeting = 'Good Morning';
    } else if (currentTime < 18) {
      greeting = 'Good Afternoon';
    } else if (currentTime < 22) {
      greeting = 'Good Evening';
    }
  }

  // Nama fungsi diubah agar lebih sesuai.
  // Logika di dalamnya disederhanakan agar tidak error.
  Future<void> onForgotPassword() async {
    if (basicValidator.validateForm()) {
      // Logika untuk mengirim email reset password akan ditambahkan di sini nanti.
      // Untuk sekarang, kita hanya akan mencetak pesan ke konsol
      // dan langsung mengarahkan pengguna.

      print(
          "Proses Lupa Password untuk email: ${basicValidator.getData()['email']}");

      // Mengarahkan pengguna ke halaman selanjutnya
      Get.toNamed('/auth/reset_password');
      update();
    }
  }

  // Fungsi untuk kembali ke halaman login
  void gotoLogIn() {
    Get.toNamed('/auth/login');
  }
}
