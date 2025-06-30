import 'package:sikilap/controller/auth/login_controller.dart';
import 'package:sikilap/helpers/theme/app_themes.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_button.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/my_text_style.dart';
import 'package:sikilap/views/layout/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with UIMixin {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Form(
            key: controller.basicValidator.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText.titleLarge("Masuk dengan email", fontWeight: 600),
                MySpacing.height(24),
                MyText.bodyMedium("buat dokumen baru untuk menggabungkan kata, data, dan istilah anda. gratis!", fontWeight: 600, xMuted: true),
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
                      filled: true,
                      fillColor: contentTheme.secondary.withAlpha(36),
                      prefixIcon: const Icon(LucideIcons.mail, size: 16),
                      contentPadding: MySpacing.all(16),
                      isDense: true,
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
                MySpacing.height(24),
                TextFormField(
                  validator: controller.basicValidator.getValidation('password'),
                  controller: controller.basicValidator.getController('password'),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !controller.showPassword,
                  style: MyTextStyle.labelMedium(),
                  decoration: InputDecoration(
                      labelText: "Kata Sandi",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      filled: true,
                      fillColor: contentTheme.secondary.withAlpha(36),
                      prefixIcon: const Icon(LucideIcons.mail, size: 16),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: InkWell(
                        onTap: controller.onChangeShowPassword,
                        child: Icon(controller.showPassword ? LucideIcons.eye : LucideIcons.eye_off, size: 16),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => controller.onChangeCheckBox(!controller.isChecked),
                      child: Row(
                        children: [
                          Checkbox(
                            onChanged: controller.onChangeCheckBox,
                            value: controller.isChecked,
                            fillColor: WidgetStatePropertyAll(Colors.white),
                            activeColor: theme.colorScheme.primary,
                            checkColor: contentTheme.primary,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: getCompactDensity,
                          ),
                          MySpacing.width(8),
                          MyText.bodySmall("Ingat Aku"),
                        ],
                      ),
                    ),
                    MyButton.text(
                      onPressed: controller.goToForgotPassword,
                      elevation: 0,
                      padding: MySpacing.xy(8, 0),
                      splashColor: contentTheme.secondary.withAlpha(36),
                      child: MyText.bodySmall('Lupa kata sandi?', color: contentTheme.secondary),
                    ),
                  ],
                ),
                MySpacing.height(28),
                Center(
                  child: MyButton.rounded(
                    onPressed: controller.onLogin,
                    elevation: 0,
                    padding: MySpacing.xy(24, 16),
                    backgroundColor: contentTheme.primary,
                    child: MyText.labelMedium('Masuk', color: contentTheme.onPrimary),
                  ),
                ),
                Center(
                  child: MyButton.text(
                    onPressed: controller.gotoRegister,
                    elevation: 0,
                    padding: MySpacing.x(24),
                    splashColor: contentTheme.secondary.withValues(alpha: 0.1),
                    child: MyText.bodySmall('Saya tidak punya akun'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
