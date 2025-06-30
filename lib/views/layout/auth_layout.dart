import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/layout/auth_layout_controller.dart';
import 'package:sikilap/helpers/theme/app_themes.dart';

import 'package:sikilap/helpers/widgets/my_flex.dart';
import 'package:sikilap/helpers/widgets/my_flex_item.dart';
import 'package:sikilap/helpers/widgets/my_responsive.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/images.dart';

class AuthLayout extends StatelessWidget {
  final Widget? child;

  final AuthLayoutController controller = AuthLayoutController();

  AuthLayout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MyResponsive(builder: (BuildContext context, _, screenMT) {
      return GetBuilder(
          init: controller,
          builder: (controller) {
            return screenMT.isMobile ? mobileScreen(context) : largeScreen(context);
          });
    });
  }

  Widget mobileScreen(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Container(
        padding: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
        height: MediaQuery.of(context).size.height,
        color: theme.cardTheme.color,
        child: Center(
            child: Padding(
          padding: MySpacing.x(flexSpacing),
          child: child,
        )),
      ),
    );
  }

  Widget largeScreen(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        body: MyFlex(
          runAlignment: WrapAlignment.center,
          wrapCrossAlignment: WrapCrossAlignment.center,
          spacing: 0,
          runSpacing: 0,
          children: [
            MyFlexItem(
              sizes: "xxl-5 lg-5 md-6 sm-12",
              child: Center(
                child: MyFlex(
                  runAlignment: WrapAlignment.center,
                  wrapCrossAlignment: WrapCrossAlignment.center,
                  children: [
                    MyFlexItem(
                      sizes: "xxl-7 lg-7 md-10 sm-12",
                      child: child ?? Container(),
                    ),
                  ],
                ),
              ),
            ),
            MyFlexItem(
              sizes: "xxl-7 lg-7 md-6 sm-0",
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  Images.auth,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ));
  }
}
