// lib/controller/auth/register_account_controller.dart

import 'package:flutter/material.dart';
// import 'package:sikilap/helpers/services/auth_services.dart';
import 'package:sikilap/helpers/widgets/my_form_validator.dart';
import 'package:sikilap/helpers/widgets/my_validators.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';

class RegisterAccountController extends MyController {
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
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'first_name',
      required: true,
      label: 'First Name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'last_name',
      required: true,
      label: 'Last Name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'phone_number',
      required: true,
      label: "No. Telepon",
      validators: [MyLengthValidator(min: 9, max: 15)], // Memastikan panjang nomor telepon wajar
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'address',
      required: true,
      label: "Alamat",
       validators: [MyLengthValidator(min: 10)], // Memastikan alamat tidak terlalu pendek
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'password',
      required: true,
      validators: [MyLengthValidator(min: 6, max: 10)],
      controller: TextEditingController(),
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
  Future<void> onRegister() async {
    if (basicValidator.validateForm()) {
      // Logika untuk mendaftarkan pengguna baru akan ditambahkan di sini nanti.
      // Untuk sekarang, kita hanya akan mencetak pesan ke konsol
      // dan langsung mengarahkan pengguna ke halaman login.

      print("Mendaftarkan pengguna: ${basicValidator.getData()}");

      // Mengarahkan pengguna ke halaman login setelah "berhasil" mendaftar
      Get.offAndToNamed(
          '/auth/login'); // Gunakan offAndToNamed agar tidak bisa kembali
      update();
    }
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void gotoLogin() {
    Get.toNamed('/auth/login');
  }
}
