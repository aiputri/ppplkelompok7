// lib/helpers/storage/local_storage.dart

import 'dart:convert'; // <-- PASTIKAN IMPORT INI ADA
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sikilap/helpers/localizations/language.dart';
import 'package:sikilap/helpers/services/auth_services.dart';
import 'package:sikilap/helpers/theme/theme_customizer.dart';
import 'package:sikilap/model/user.dart'; // <-- PASTIKAN IMPORT INI ADA

class LocalStorage {
  static const String _loggedInUserKey =
      "user_data"; // Ganti nama key agar tidak bentrok
  static const String _themeCustomizerKey = "theme_customizer";
  static const String _languageKey = "lang_code";

  static SharedPreferences? _preferencesInstance;

  static SharedPreferences get preferences {
    if (_preferencesInstance == null) {
      throw ("Call LocalStorage.init() to initialize local storage");
    }
    return _preferencesInstance!;
  }

  static Future<void> init() async {
    _preferencesInstance = await SharedPreferences.getInstance();
    await initData();
  }

  static Future<void> initData() async {
    await AuthService
        .loadUserFromStorage(); // Panggil ini untuk load data dari storage

    SharedPreferences preferences = await SharedPreferences.getInstance();
    ThemeCustomizer.fromJSON(preferences.getString(_themeCustomizerKey));
  }

  // --- INI BAGIAN YANG DIPERBAIKI ---
  // Sekarang menerima objek User dan menyimpannya sebagai String JSON
  static Future<bool> setLoggedInUser(User user) async {
    return preferences.setString(_loggedInUserKey, json.encode(user.toJson()));
  }

  // Method baru untuk membaca objek User dari String JSON
  static Future<User?> getLoggedInUser() async {
    String? userDataString = preferences.getString(_loggedInUserKey);
    if (userDataString != null) {
      return User.fromJson(json.decode(userDataString));
    }
    return null;
  }
  // ---------------------------------

  static Future<bool> setCustomizer(ThemeCustomizer themeCustomizer) {
    return preferences.setString(_themeCustomizerKey, themeCustomizer.toJSON());
  }

  static Future<bool> setLanguage(Language language) {
    return preferences.setString(_languageKey, language.locale.languageCode);
  }

  static String? getLanguage() {
    return preferences.getString(_languageKey);
  }

  static Future<bool> removeLoggedInUser() async {
    return preferences.remove(_loggedInUserKey);
  }
}
