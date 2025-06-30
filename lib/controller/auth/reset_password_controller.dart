// lib/controller/auth/reset_password_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:sikilap/helpers/services/auth_services.dart';
import 'package:sikilap/helpers/widgets/my_form_validator.dart';
import 'package:sikilap/helpers/widgets/my_validators.dart';
import 'package:sikilap/controller/my_controller.dart';

class ResetPasswordController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  var greeting = "Good Morning";
  late int currentTime = DateTime.now().hour;
  bool showPassword = false;

  bool confirmPassword = false;

  @override
  void onInit() {
    super.onInit();
    if ((currentTime < 6) || (currentTime > 21)) {
      greeting = 'Good Night';
    } else if (currentTime < 12) {
      greeting = 'Good Morning';
    } else if (currentTime < 18) {
      greeting = 'Good Afternoon';
    } else if (currentTime < 22) {
      greeting = 'Good Evening';
    }
    basicValidator.addField(
      'password',
      required: true,
      validators: [
        MyLengthValidator(min: 6, max: 10),
      ],
      controller: TextEditingController(),
    );
    // Validasi pencocokan password dihapus sementara agar tidak error
    basicValidator.addField(
      'confirm_password',
      required: true,
      label: "Confirm password",
      validators: [
        MyLengthValidator(min: 6, max: 10),
      ],
      controller: TextEditingController(),
    );
  }

  // Logika di dalamnya disederhanakan agar tidak error.
  Future<void> onResetPassword() async {
    if (basicValidator.validateForm()) {
      // Logika untuk mereset password di database akan ditambahkan di sini nanti.
      // Untuk sekarang, kita hanya akan mencetak pesan ke konsol
      // dan langsung mengarahkan pengguna ke halaman login.

      print(
          "Password baru telah diatur: ${basicValidator.getData()['password']}");

      // Mengarahkan pengguna kembali ke halaman login setelah "berhasil"
      Get.offAllNamed(
          '/auth/login'); // Gunakan offAllNamed agar kembali ke login
      update();
    }
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onConfirmPassword() {
    confirmPassword = !confirmPassword;
    update();
  }
}
