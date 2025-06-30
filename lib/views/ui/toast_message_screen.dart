import 'package:sikilap/controller/ui/toast_message_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_flex.dart';
import 'package:sikilap/helpers/widgets/my_flex_item.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ToastMessageScreen extends StatefulWidget {
  const ToastMessageScreen({super.key});

  @override
  State<ToastMessageScreen> createState() => _ToastMessageScreenState();
}

class _ToastMessageScreenState extends State<ToastMessageScreen> with SingleTickerProviderStateMixin, UIMixin {
  late ToastMessageController controller;

  @override
  void initState() {
    controller = ToastMessageController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'toast_message_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Toast",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Widgets'),
                        MyBreadcrumbItem(name: 'Toast', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                      sizes: 'lg-4 md-6',
                      child: MyCard(
                        shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        paddingAll: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.titleMedium("Simple Toast Message", fontWeight: 600),
                            MySpacing.height(24),
                            simpleMessage("Primary", contentTheme.primary),
                            MySpacing.height(24),
                            simpleMessage("Secondary", contentTheme.secondary),
                            MySpacing.height(24),
                            simpleMessage("Success", contentTheme.success),
                            MySpacing.height(24),
                            simpleMessage("Warning", contentTheme.info),
                            MySpacing.height(24),
                            simpleMessage("Info", contentTheme.warning),
                            MySpacing.height(24),
                            simpleMessage("Danger", contentTheme.danger),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                        sizes: 'lg-4 md-6',
                        child: MyCard(
                          shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          paddingAll: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.titleMedium("Light Background Toast", fontWeight: 600),
                              MySpacing.height(24),
                              lightBackgroundMessage("Primary", contentTheme.primary),
                              MySpacing.height(24),
                              lightBackgroundMessage("Secondary", contentTheme.secondary),
                              MySpacing.height(24),
                              lightBackgroundMessage("Success", contentTheme.success),
                              MySpacing.height(24),
                              lightBackgroundMessage("Warning", contentTheme.info),
                              MySpacing.height(24),
                              lightBackgroundMessage("Info", contentTheme.warning),
                              MySpacing.height(24),
                              lightBackgroundMessage("Danger", contentTheme.danger),
                            ],
                          ),
                        )),
                    MyFlexItem(
                        sizes: 'lg-4 md-6',
                        child: MyCard(
                          shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          paddingAll: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.titleMedium("Icon Toast", fontWeight: 600),
                              MySpacing.height(24),
                              iconToastMessage(LucideIcons.panel_top, "Primary", contentTheme.primary),
                              MySpacing.height(24),
                              iconToastMessage(LucideIcons.tally_4, "Secondary", contentTheme.secondary),
                              MySpacing.height(24),
                              iconToastMessage(LucideIcons.badge_check, "Success", contentTheme.success),
                              MySpacing.height(24),
                              iconToastMessage(LucideIcons.info, "Info", contentTheme.info),
                              MySpacing.height(24),
                              iconToastMessage(LucideIcons.octagon_alert, "Warning", contentTheme.warning),
                              MySpacing.height(24),
                              iconToastMessage(LucideIcons.skull, "Danger", contentTheme.danger),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget simpleMessage(String messageTitle, Color color) {
    return MyContainer(
      paddingAll: 0,
      height: 54,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: double.infinity,
      onTap: () {
        simpleToastMessage(messageTitle, color);
      },
      color: color,
      child: Center(
        child: MyText.bodyMedium(
          messageTitle,
          fontWeight: 600,
          color: contentTheme.onPrimary,
        ),
      ),
    );
  }

  Widget lightBackgroundMessage(String messageTitle, Color color) {
    return MyContainer.bordered(
      paddingAll: 0,
      height: 54,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: double.infinity,
      borderColor: color,
      color: color.withAlpha(36),
      onTap: () {
        lightBackgroundToastMessage(messageTitle, color);
      },
      child: Center(child: MyText.bodyMedium(messageTitle, fontWeight: 600, color: color)),
    );
  }

  Widget iconToastMessage(IconData icon, String messageText, Color color) {
    return InkWell(
      onTap: () => iconMessage(messageText, icon, color),
      child: Row(
        children: [
          MyContainer(
            paddingAll: 24,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: color.withAlpha(36),
            child: Icon(icon, size: 20, color: color),
          ),
          MySpacing.width(24),
          MyText.bodyMedium(messageText, fontWeight: 600),
        ],
      ),
    );
  }

  void simpleToastMessage(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      shape: OutlineInputBorder(borderSide: BorderSide.none),
      width: 300,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1200),
      animation: Tween<double>(begin: 0, end: 300).animate(controller.animationController),
      content: MyText.labelLarge(text, fontWeight: 600, color: contentTheme.onPrimary),
      backgroundColor: color,
    ));
  }

  void lightBackgroundToastMessage(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      shape: OutlineInputBorder(borderSide: BorderSide(color: color)),
      width: 300,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1200),
      animation: Tween<double>(begin: 0, end: 300).animate(controller.animationController),
      content: MyText.labelLarge(text, fontWeight: 600, color: color),
      backgroundColor: color.withAlpha(36),
    ));
  }

  void iconMessage(String text, IconData icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: .5,
      shape: OutlineInputBorder(borderSide: BorderSide.none),
      width: 300,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1200),
      animation: Tween<double>(begin: 0, end: 300).animate(controller.animationController),
      content: Row(
        children: [
          MyContainer(
            height: 32,
            width: 32,
            paddingAll: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: color.withAlpha(36),
            child: Icon(icon, size: 20, color: color),
          ),
          MySpacing.width(12),
          MyText.bodyMedium(text, fontWeight: 600),
        ],
      ),
      backgroundColor: contentTheme.onPrimary,
    ));
  }
}
