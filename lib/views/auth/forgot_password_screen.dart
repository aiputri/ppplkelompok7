import 'package:stay_place/controller/auth/forgot_password_controller.dart';
import 'package:stay_place/helpers/utils/ui_mixins.dart';
import 'package:stay_place/helpers/widgets/my_button.dart';
import 'package:stay_place/helpers/widgets/my_spacing.dart';
import 'package:stay_place/helpers/widgets/my_text.dart';
import 'package:stay_place/helpers/widgets/my_text_style.dart';
import 'package:stay_place/views/layout/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with UIMixin {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Form(
              key: controller.basicValidator.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.titleLarge("Lupa Kata Sandi", fontWeight: 600),
                  MySpacing.height(24),
                  MyText.bodyMedium(
                      "masukkan alamat email yang terkait dengan akun anda dan kami akan mengirimkan instruksi email tentang cara memulihkan kata sandi anda.",
                      fontWeight: 600,
                      xMuted: true),
                  MySpacing.height(24),
                  TextFormField(
                    validator: controller.basicValidator.getValidation('email'),
                    controller:
                        controller.basicValidator.getController('email'),
                    keyboardType: TextInputType.emailAddress,
                    style: MyTextStyle.labelMedium(),
                    decoration: InputDecoration(
                      labelText: "Alamat Email",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      filled: true,
                      fillColor: contentTheme.secondary.withAlpha(36),
                      prefixIcon: Icon(LucideIcons.mail, size: 16),
                      contentPadding: MySpacing.all(15),
                      isDense: true,
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  MySpacing.height(24),
                  Center(
                    child: MyButton.rounded(
                      onPressed: controller.onForgotPassword,
                      elevation: 0,
                      padding: MySpacing.xy(24, 16),
                      backgroundColor: contentTheme.primary,
                      child: MyText.labelMedium('Lupa Kata Sandi',
                          color: contentTheme.onPrimary),
                    ),
                  ),
                  Center(
                    child: MyButton.text(
                      onPressed: controller.gotoLogIn,
                      elevation: 0,
                      padding: MySpacing.x(24),
                      splashColor:
                          contentTheme.secondary.withValues(alpha: 0.1),
                      child: MyText.labelMedium('Kembali untuk masuk',
                          color: contentTheme.secondary),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
