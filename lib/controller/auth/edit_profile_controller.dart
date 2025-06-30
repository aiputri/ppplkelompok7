// lib/controller/auth/edit_profile_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/helpers/services/auth_services.dart';

class EditProfileController extends MyController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  @override
  void onInit() {
    super.onInit();
    final user = AuthService.loggedInUser.value;

    // Inisialisasi controller dengan data user yang sedang login
    firstNameController = TextEditingController(text: user?.firstName ?? '');
    lastNameController = TextEditingController(text: user?.lastName ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
  }

  void saveProfile() {
    if (formKey.currentState!.validate()) {
      // 1. Ambil data baru dari controller
      String newFirstName = firstNameController.text;
      String newLastName = lastNameController.text;

      // 2. Tampilkan dialog sukses (atau snackbar)
      Get.dialog(AlertDialog(
        title: Text("Success"),
        content: Text(
            "Profile updated successfully! (Data: $newFirstName $newLastName)"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Tutup dialog
              Get.back(); // Kembali ke halaman profil
            },
            child: Text("OK"),
          ),
        ],
      ));

      // 3. (Langkah selanjutnya) Di sini kamu akan memanggil service untuk
      //    mengirim data baru ini ke backend/database.
      //
      //    Contoh:
      //    await UserService.updateProfile({
      //      'first_name': newFirstName,
      //      'last_name': newLastName,
      //    });
      //
      //    Setelah itu, jangan lupa update state di AuthService.loggedInUser juga.
    }
  }

  @override
  void onClose() {
    // Selalu dispose controller untuk menghindari memory leak
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
