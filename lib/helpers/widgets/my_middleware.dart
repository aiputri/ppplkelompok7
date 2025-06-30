// lib/helpers/widgets/my_middleware.dart

import 'package:sikilap/helpers/services/auth_services.dart';

abstract class MyMiddleware {
  String name = 'middleware';
  String handle(String routeName);
}

/// Middleware untuk memastikan pengguna sudah login.
/// Jika belum, akan diarahkan ke halaman login.
class AuthMiddleware extends MyMiddleware {
  @override
  String handle(String route) {
    // Cek ke AuthService apakah user sudah login
    // Menggunakan getter 'isLoggedIn' yang benar
    if (AuthService.isLoggedIn) {
      // Jika sudah login, izinkan akses. Kembalikan rute asli.
      return route;
    }
    // Jika belum login, paksa arahkan ke halaman login.
    // Tambahkan rute asli sebagai parameter 'next' agar bisa kembali setelah login.
    return "/auth/login?next=$route";
  }
}

/// Middleware untuk memastikan pengguna adalah admin.
/// Jika bukan, akan diarahkan ke halaman home.
class AdminMiddleware extends MyMiddleware {
  @override
  String handle(String route) {
    // Cek apakah pengguna sudah login DAN perannya adalah admin.
    // Menggunakan getter 'isLoggedIn' dan mengakses 'loggedInUser' yang static
    // Kode Baru (tanpa peringatan)
    if (AuthService.isLoggedIn && AuthService.loggedInUser.value!.isAdmin()) {
      // Jika ya, izinkan akses.
      return route;
    }
    // Jika bukan admin (atau belum login), tendang ke halaman home client.
    return "/home";
  }
}
