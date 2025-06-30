import 'package:stay_place/controller/auth/register_account_controller.dart';
import 'package:stay_place/helpers/utils/ui_mixins.dart';
import 'package:stay_place/helpers/widgets/my_button.dart';
import 'package:stay_place/helpers/widgets/my_spacing.dart';
import 'package:stay_place/helpers/widgets/my_text.dart';
import 'package:stay_place/helpers/widgets/my_text_style.dart';
import 'package:stay_place/views/layout/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class RegisterAccountScreen extends StatefulWidget {
  const RegisterAccountScreen({super.key});

  @override
  State<RegisterAccountScreen> createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen>
    with UIMixin {
  RegisterAccountController controller = Get.put(RegisterAccountController());

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Form(
            key: controller.basicValidator.formKey,
            child: SingleChildScrollView( // Ditambahkan agar bisa di-scroll jika layar kecil
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText.titleLarge("Mendaftar", fontWeight: 600),
                  MySpacing.height(24),
                  MyText.bodyMedium(
                      "kami senang anda bergabung, mohon aktifkan akun anda dengan mengisi rincian di bawah ini",
                      fontWeight: 600,
                      xMuted: true),
                  MySpacing.height(24),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: controller.basicValidator
                              .getValidation('first_name'),
                          controller: controller.basicValidator
                              .getController('first_name'),
                          keyboardType: TextInputType.name,
                          style: MyTextStyle.labelMedium(),
                          decoration: InputDecoration(
                            labelText: "Nama Depan",
                            labelStyle: MyTextStyle.bodySmall(xMuted: true),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            prefixIcon: const Icon(LucideIcons.user, size: 16),
                            fillColor: contentTheme.secondary.withAlpha(36),
                            filled: true,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                      MySpacing.width(24),
                      Expanded(
                        child: TextFormField(
                          validator: controller.basicValidator
                              .getValidation('last_name'),
                          controller: controller.basicValidator
                              .getController('last_name'),
                          keyboardType: TextInputType.name,
                          style: MyTextStyle.labelMedium(),
                          decoration: InputDecoration(
                            labelText: "Nama Belakang",
                            labelStyle: MyTextStyle.bodySmall(xMuted: true),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            prefixIcon: const Icon(LucideIcons.user, size: 16),
                            filled: true,
                            fillColor: contentTheme.secondary.withAlpha(36),
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                  MySpacing.height(24),
                  TextFormField(
                    validator: controller.basicValidator.getValidation('email'),
                    controller: controller.basicValidator.getController('email'),
                    keyboardType: TextInputType.emailAddress,
                    style: MyTextStyle.labelMedium(),
                    decoration: InputDecoration(
                      labelText: "Alamat Email",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: const Icon(LucideIcons.mail, size: 16),
                      filled: true,
                      fillColor: contentTheme.secondary.withAlpha(36),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  MySpacing.height(24),
                  TextFormField(
                    validator: controller.basicValidator.getValidation('phone_number'),
                    controller: controller.basicValidator.getController('phone_number'),
                    keyboardType: TextInputType.phone,
                    style: MyTextStyle.labelMedium(),
                    decoration: InputDecoration(
                      labelText: "No. Telepon",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: const Icon(LucideIcons.phone, size: 16),
                      filled: true,
                      fillColor: contentTheme.secondary.withAlpha(36),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  MySpacing.height(24),
                  TextFormField(
                    validator: controller.basicValidator.getValidation('address'),
                    controller: controller.basicValidator.getController('address'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3, // Membuat field ini bisa beberapa baris
                    style: MyTextStyle.labelMedium(),
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: const Icon(LucideIcons.bomb, size: 16),
                      filled: true,
                      fillColor: contentTheme.secondary.withAlpha(36),
                      contentPadding: MySpacing.all(16),
                      // isCollapsed: true, // <-- BARIS INI DIHAPUS
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  MySpacing.height(24),
                  TextFormField(
                    validator:
                        controller.basicValidator.getValidation('password'),
                    controller:
                        controller.basicValidator.getController('password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !controller.showPassword,
                    style: MyTextStyle.labelMedium(),
                    decoration: InputDecoration(
                        labelText: "Kata Sandi",
                        labelStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        prefixIcon: const Icon(
                          LucideIcons.lock,
                          size: 16,
                        ),
                        filled: true,
                        fillColor: contentTheme.secondary.withAlpha(36),
                        isDense: true,
                        suffixIcon: InkWell(
                          onTap: controller.onChangeShowPassword,
                          child: Icon(
                            controller.showPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 16,
                          ),
                        ),
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                  MySpacing.height(30),
                  Center(
                    child: MyButton.rounded(
                      onPressed: controller.onRegister,
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      backgroundColor: contentTheme.primary,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyText.bodySmall('Daftar',
                              color: contentTheme.onPrimary),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: MyButton.text(
                      onPressed: controller.gotoLogin,
                      elevation: 0,
                      padding: MySpacing.x(24),
                      splashColor: contentTheme.secondary.withValues(alpha: 0.1),
                      child: MyText.labelMedium(
                        'Sudah punya akun?',
                        color: contentTheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}