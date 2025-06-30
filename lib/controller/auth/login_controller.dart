// lib/controller/auth/login_controller.dart

import 'package:flutter/material.dart';
import 'package:sikilap/helpers/services/auth_services.dart';
import 'package:sikilap/helpers/widgets/my_form_validator.dart';
import 'package:sikilap/helpers/widgets/my_validators.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, isChecked = false;

  final String _dummyEmail = "admin@stayplace.com";
  final String _dummyPassword = "1234567";

  var greeting = "Good Morning";
  late int currentTime = DateTime.now().hour;

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField('email',
        required: true,
        label: "Email",
        validators: [MyEmailValidator()],
        controller: TextEditingController(text: _dummyEmail));

    basicValidator.addField('password',
        required: true,
        label: "Password",
        validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController(text: _dummyPassword));

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

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      update();
      var user = await AuthService.login(basicValidator.getData());

      if (user == null) {
        basicValidator
            .addErrors({"password": "Email or Password is incorrect"});
        basicValidator.validateForm();
        basicValidator.clearErrors();
      } else {
        // ========== LOGIKA SUPER SIMPEL & FINAL ==========
        if (user.isAdmin()) {
          // Jika admin, paksa ke dashboard admin.
          Get.offAllNamed('/admin/dashboard');
        } else {
          // Jika bukan admin (client), paksa ke home.
          Get.offAllNamed('/home');
        }
        // ===============================================
      }
      update();
    }
  }

  void goToForgotPassword() {
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    Get.offAndToNamed('/auth/register_account');
  }
}
