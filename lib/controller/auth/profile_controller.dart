// lib/controller/profile_controller.dart
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/helpers/services/auth_services.dart';
import 'package:sikilap/model/user.dart';

class ProfileController extends MyController {
  // Ambil data user langsung dari AuthService
  User? user = AuthService.loggedInUser.value;

  // Kamu bisa tambahkan fungsi untuk mengedit profil di sini
  void editProfile() {
    // ... logika untuk membuka halaman edit atau dialog
  }
}
