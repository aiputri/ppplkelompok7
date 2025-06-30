// lib/views/auth/edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stay_place/controller/auth/edit_profile_controller.dart';
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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with UIMixin {
  late final EditProfileController controller;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller di initState agar bisa mengakses data awal
    controller = Get.put(EditProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<EditProfileController>(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Edit Profil",
                        fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Profil'),
                        MyBreadcrumbItem(name: 'Edit', active: true),
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
                        _buildTextField(
                          title: "Nama Depan",
                          hintText: "Masukkan Nama Depan",
                          controller: controller.firstNameController,
                          validator: (value) =>
                              value!.isEmpty ? "Nama depan diperlukan" : null,
                        ),
                        MySpacing.height(24),
                        _buildTextField(
                          title: "Nama Belakang",
                          hintText: "Masukkan Nama Belakang",
                          controller: controller.lastNameController,
                          validator: (value) =>
                              value!.isEmpty ? "Nama belakang diperlukan" : null,
                        ),
                        MySpacing.height(24),
                        // Email tidak bisa diedit
                        _buildTextField(
                          title: "Email",
                          hintText: "Email",
                          controller: controller.emailController,
                          enabled: false, // <-- Buat non-aktif
                        ),
                        MySpacing.height(32),
                        Center(
                          child: MyButton.rounded(
                            onPressed: controller.saveProfile,
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            child: MyText.bodyMedium("Simpan Perubahan",
                                color: contentTheme.onPrimary),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  // Widget helper untuk membuat text field, meniru `add_guest_screen`
  Widget _buildTextField({
    required String title,
    required String hintText,
    required TextEditingController controller,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelMedium(title),
        MySpacing.height(12),
        TextFormField(
          controller: controller,
          validator: validator,
          enabled: enabled,
          style: MyTextStyle.labelMedium(),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MyTextStyle.labelMedium(xMuted: true),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: contentTheme.primary)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withAlpha(150))),
            contentPadding: MySpacing.all(14),
            isCollapsed: true,
            isDense: true,
          ),
        )
      ],
    );
  }
}
