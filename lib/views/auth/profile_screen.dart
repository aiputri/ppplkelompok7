// lib/views/auth/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stay_place/controller/auth/profile_controller.dart';
import 'package:stay_place/helpers/utils/my_shadow.dart';
import 'package:stay_place/helpers/utils/ui_mixins.dart';
import 'package:stay_place/helpers/widgets/my_button.dart';
import 'package:stay_place/helpers/widgets/my_card.dart';
import 'package:stay_place/helpers/widgets/my_container.dart';
import 'package:stay_place/helpers/widgets/my_flex.dart';
import 'package:stay_place/helpers/widgets/my_flex_item.dart';
import 'package:stay_place/helpers/widgets/my_spacing.dart';
import 'package:stay_place/helpers/widgets/my_text.dart';
import 'package:stay_place/images.dart';
import 'package:stay_place/views/layout/layout.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with UIMixin {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<ProfileController>(
        init: controller,
        builder: (controller) {
          final user = controller.user;

          return Padding(
            padding: MySpacing.all(24),
            child: MyFlex(
              children: [
                MyFlexItem(
                  sizes: "lg-4 md-12",
                  child: MyCard(
                    shadow: MyShadow(elevation: 0.5),
                    paddingAll: 24,
                    child: Column(
                      children: [
                        MyContainer.rounded(
                          paddingAll: 0,
                          child: Image.asset(
                            Images.avatars[2], // Contoh avatar
                            height: 100,
                            width: 100,
                          ),
                        ),
                        MySpacing.height(16),
                        if (user != null) ...[
                          MyText.titleLarge(user.name, fontWeight: 600),
                          MySpacing.height(4),
                          MyText.bodyMedium(user.role.capitalizeFirst ?? ''),
                        ]
                      ],
                    ),
                  ),
                ),
                MyFlexItem(
                  sizes: "lg-8 md-12",
                  child: MyCard(
                    shadow: MyShadow(elevation: 0.5),
                    paddingAll: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.titleMedium("Informasi Profil",
                            fontWeight: 600),
                        MySpacing.height(24),
                        if (user != null) ...[
                          _buildProfileInfoRow(
                            icon: LucideIcons.user,
                            title: "Nama Lengkap",
                            value: user.name,
                          ),
                          Divider(height: 32),
                          _buildProfileInfoRow(
                            icon: LucideIcons.mail,
                            title: "Email",
                            value: user.email,
                          ),
                          Divider(height: 32),
                          _buildProfileInfoRow(
                            icon: LucideIcons.shield,
                            title: "Role",
                            value: user.role.capitalizeFirst ?? '',
                          ),
                        ] else
                          MyText.bodyLarge("Data pengguna tidak ditemukan."),
                        MySpacing.height(24),
                        if (user != null && user.isAdmin())
                          MyContainer.none(
                            padding: MySpacing.all(16),
                            color: contentTheme.primary.withAlpha(40),
                            child: Row(
                              children: [
                                Icon(LucideIcons.triangle,
                                    size: 20, color: contentTheme.primary),
                                MySpacing.width(16),
                                Expanded(
                                  child: MyText.bodyMedium(
                                    "Ini adalah tampilan tambahan khusus untuk Admin.",
                                    color: contentTheme.primary,
                                    fontWeight: 600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        MySpacing.height(16),
                        Center(
                          child: MyButton.rounded(
                            onPressed: () {
                              Get.toNamed(
                                  '/profile/edit'); // Logika untuk edit profil bisa ditambahkan di sini
                            },
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            child: MyText.bodyMedium("Edit Profil",
                                color: contentTheme.onPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget helper untuk membuat baris info profil
  Widget _buildProfileInfoRow(
      {required IconData icon, required String title, required String value}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: contentTheme.onBackground.withAlpha(150)),
        MySpacing.width(16),
        Expanded(
          child: MyText.bodyMedium(title, fontWeight: 600),
        ),
        MySpacing.width(16),
        Expanded(
          flex: 2,
          child: MyText.bodyMedium(value),
        ),
      ],
    );
  }
}
