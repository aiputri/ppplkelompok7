// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart'; // <-- IMPORT BARU YANG PENTING
import 'package:sikilap/helpers/localizations/app_localization_delegate.dart';
import 'package:sikilap/helpers/localizations/language.dart';
import 'package:sikilap/helpers/services/auth_services.dart';
import 'package:sikilap/helpers/services/booking_service.dart';
import 'package:sikilap/helpers/services/payment_service.dart';
import 'package:sikilap/helpers/services/navigation_service.dart';
import 'package:sikilap/helpers/storage/local_storage.dart';
import 'package:sikilap/helpers/theme/app_notifire.dart';
import 'package:sikilap/helpers/theme/app_style.dart';
import 'package:sikilap/helpers/theme/theme_customizer.dart';
import 'package:sikilap/routes.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  Get.lazyPut(() => AuthService(), fenix: true);
  Get.lazyPut(() => BookingService(), fenix: true);
  Get.lazyPut(() => PaymentService(), fenix: true);

  await LocalStorage.init();
  AppStyle.init();
  await ThemeCustomizer.init();

  runApp(ChangeNotifierProvider<AppNotifier>(
    create: (context) => AppNotifier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (_, notifier, ___) {
        String initialRoute;
        if (AuthService.isLoggedIn) {
          if (AuthService.loggedInUser.value!.isAdmin()) {
            initialRoute = '/admin/dashboard';
          } else {
            initialRoute = '/home';
          }
        } else {
          initialRoute = '/auth/login';
        }

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeCustomizer.instance.theme,
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: initialRoute,
          getPages: getPageRoute(),
          builder: (context, child) {
            NavigationService.registerContext(context);
            return Directionality(
                textDirection: AppTheme.textDirection,
                child: child ?? Container());
          },
          // ========== TAMBAHKAN DELEGATE DI SINI ==========
          localizationsDelegates: [
            AppLocalizationsDelegate(context),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FlutterQuillLocalizations.delegate, // <-- BARIS BARU
          ],
          // ================================================
          supportedLocales: [
            ...Language.getLocales(),
            const Locale(
                'en', 'US'), // Pastikan bahasa Inggris didukung untuk Quill
          ],
        );
      },
    );
  }
}
