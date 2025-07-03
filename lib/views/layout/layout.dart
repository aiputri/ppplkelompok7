// lib/views/layout/layout.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/layout/layout_controller.dart';
import 'package:sikilap/helpers/services/auth_services.dart';
import 'package:sikilap/helpers/theme/admin_theme.dart';
import 'package:sikilap/helpers/theme/app_style.dart';
import 'package:sikilap/helpers/theme/app_themes.dart';
import 'package:sikilap/helpers/theme/theme_customizer.dart';
import 'package:sikilap/helpers/widgets/my_button.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_dashed_divider.dart';
import 'package:sikilap/helpers/widgets/my_responsive.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/left_bar.dart';
import 'package:sikilap/views/layout/right_bar.dart';
import 'package:sikilap/views/layout/top_bar.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class Layout extends StatelessWidget {
  final Widget? child;

  final LayoutController controller = LayoutController();
  final topBarTheme = AdminTheme.theme.topBarTheme;
  final contentTheme = AdminTheme.theme.contentTheme;

  Layout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MyResponsive(builder: (BuildContext context, _, screenMT) {
      return GetBuilder(
          init: controller,
          builder: (controller) {
            return screenMT.isMobile ? mobileScreen() : largeScreen();
          });
    });
  }

  Widget mobileScreen() {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Row(),
        actions: [],
      ),
      // ----- GUNAKAN Obx DENGAN VALUEKEY -----
      drawer: Obx(() {
        if (!AuthService.isLoggedIn) {
          return const SizedBox.shrink();
        }
        // ValueKey akan memaksa widget dihancurkan dan dibuat ulang jika role berubah
        return LeftBar(
          key:
              ValueKey(AuthService.loggedInUser.value!.role), // <-- KUNCI UTAMA
          isAdmin: AuthService.loggedInUser.value!.isAdmin(),
        );
      }),
      // -----------------------------------------
      body: SingleChildScrollView(
        key: controller.scrollKey,
        child: child,
      ),
    );
  }

  Widget largeScreen() {
    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: RightBar(),
      body: Row(
        children: [
          // ----- GUNAKAN Obx DENGAN VALUEKEY -----
          Obx(() {
            if (!AuthService.isLoggedIn) {
              return const SizedBox.shrink();
            }
            // ValueKey akan memaksa widget dihancurkan dan dibuat ulang jika role berubah
            return LeftBar(
              key: ValueKey(
                  AuthService.loggedInUser.value!.role), // <-- KUNCI UTAMA
              isCondensed: ThemeCustomizer.instance.leftBarCondensed,
              isAdmin: AuthService.loggedInUser.value!.isAdmin(),
            );
          }),
          // ------------------------------------------
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    padding:
                        MySpacing.fromLTRB(0, 58 + flexSpacing, 0, flexSpacing),
                    key: controller.scrollKey,
                    child: child,
                  ),
                ),
                // Pastikan TopBar juga reaktif jika menampilkan nama user
                Obx(() => Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: TopBar(
                        key: ValueKey(AuthService.loggedInUser.value?.email ??
                            'logged_out'),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopBar(IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
      ],
    );
  }

  // ... (Sisa kode buildNotifications dan buildAccountMenu tidak perlu diubah)
  Widget buildNotifications() {
    Widget buildNotification(String title, String description) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.labelLarge(title),
          MySpacing.height(4),
          MyText.bodySmall(description)
        ],
      );
    }

    return MyContainer.bordered(
      paddingAll: 0,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(16, 12),
            child: MyText.titleMedium("Notification", fontWeight: 600),
          ),
          MyDashedDivider(
              height: 1, color: theme.dividerColor, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: MySpacing.xy(16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNotification("Your order is received",
                    "Order #1232 is ready to deliver"),
                MySpacing.height(12),
                buildNotification("Account Security ",
                    "Your account password changed 1 hour ago"),
              ],
            ),
          ),
          MyDashedDivider(
              height: 1, color: theme.dividerColor, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: MySpacing.xy(16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton.text(
                  onPressed: () {},
                  splashColor: contentTheme.primary.withAlpha(28),
                  child: MyText.labelSmall(
                    "View All",
                    color: contentTheme.primary,
                  ),
                ),
                MyButton.text(
                  onPressed: () {},
                  splashColor: contentTheme.danger.withAlpha(28),
                  child: MyText.labelSmall(
                    "Clear",
                    color: contentTheme.danger,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAccountMenu() {
    return MyContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyButton(
                  onPressed: () => {},
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: theme.colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.user,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "My Account",
                        fontWeight: 600,
                      )
                    ],
                  ),
                ),
                MySpacing.height(4),
                MyButton(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () => {},
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: theme.colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.settings,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "Settings",
                        fontWeight: 600,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => {},
              borderRadiusAll: AppStyle.buttonRadius.medium,
              padding: MySpacing.xy(8, 4),
              splashColor: contentTheme.danger.withAlpha(28),
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    LucideIcons.log_out,
                    size: 14,
                    color: contentTheme.danger,
                  ),
                  MySpacing.width(8),
                  MyText.labelMedium(
                    "Log out",
                    fontWeight: 600,
                    color: contentTheme.danger,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
