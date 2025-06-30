import 'package:flutter/material.dart';
import 'package:sikilap/controller/ui/error_pages/error_404_controller.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:get/get.dart';
import 'package:sikilap/images.dart';

class Error404Screen extends StatefulWidget {
  const Error404Screen({super.key});

  @override
  State<Error404Screen> createState() => _Error404ScreenState();
}

class _Error404ScreenState extends State<Error404Screen> with SingleTickerProviderStateMixin, UIMixin {
  late Error404Controller controller;

  @override
  void initState() {
    controller = Error404Controller();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      tag: 'error_404_controller',
      builder: (controller) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                fit: StackFit.expand,
                children: [Image.asset(Images.dummy[1], fit: BoxFit.cover), Container(color: Colors.black.withValues(alpha: .6))],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText.displayLarge("Page Not Found!", fontWeight: 600, color: contentTheme.onPrimary, textAlign: TextAlign.center),
                  MyText.displayLarge("404", fontWeight: 600, fontSize: 200, color: contentTheme.onPrimary, textAlign: TextAlign.center),
                  MySpacing.height(40),
                  MyContainer(
                    onTap: () => controller.goToDashboardScreen(),
                    borderRadiusAll: 8,
                    color: contentTheme.primary,
                    height: 44,
                    width: 200,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Center(
                        child: MyText.bodyLarge(
                      "Back to home",
                      color: contentTheme.onPrimary,
                    )),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
