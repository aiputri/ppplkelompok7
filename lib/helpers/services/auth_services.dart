// lib/helpers/services/auth_services.dart

import 'package:get/get.dart'; // <-- TAMBAHKAN IMPORT INI
import 'package:sikilap/model/user.dart';
import 'package:sikilap/helpers/storage/local_storage.dart';

class AuthService {
  static const String _adminEmail = "admin@stayplace.com";
  static const String _clientEmail = "stayplace@getappui.com";
  static const String _password = "1234567";

  // ----- UBAH BAGIAN INI MENJADI REAKTIF -----
  // Kita bungkus User dengan Rx agar bisa diamati
  static final Rx<User?> loggedInUser = Rx(null);

  // Getter sekarang akan membaca dari .value
  static bool get isLoggedIn => loggedInUser.value != null;
  // ------------------------------------------

  static Future<User?> login(Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 1));
    String email = data['email'];
    String password = data['password'];

    if (password != _password) return null;

    User? tempUser;
    if (email == _adminEmail) {
      tempUser = User(-1, _adminEmail, "Admin", "User", role: 'admin');
    } else if (email == _clientEmail) {
      tempUser = User(-1, _clientEmail, "Denish", "Navadiya", role: 'client');
    } else {
      return null;
    }

    await LocalStorage.setLoggedInUser(tempUser);

    // Perbarui nilai state reaktif kita
    loggedInUser.value = tempUser;

    return tempUser;
  }

  static Future<void> logout() async {
    await LocalStorage.removeLoggedInUser();
    // Perbarui nilai state reaktif kita
    loggedInUser.value = null;
    Get.offAllNamed('/auth/login'); // Arahkan ke login setelah logout
  }

  static Future<void> loadUserFromStorage() async {
    // Perbarui nilai state reaktif kita
    loggedInUser.value = await LocalStorage.getLoggedInUser();
  }
}
