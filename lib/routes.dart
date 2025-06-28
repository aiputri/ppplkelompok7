// lib/routes.dart (atau di mana pun file ini berada)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stay_place/helpers/services/auth_services.dart';

// Import semua screen kamu di sini
import 'package:stay_place/views/admin/admin_payment_history_screen.dart';
import 'package:stay_place/views/admin/dashboard_screen.dart';
import 'package:stay_place/views/admin/guest/add_guest_screen.dart';
import 'package:stay_place/views/admin/guest/edit_guest_screen.dart';
import 'package:stay_place/views/admin/guest/guest_list_screen.dart';
import 'package:stay_place/views/admin/manage_booking/booking_list_screen.dart';
import 'package:stay_place/views/admin/manage_hotels/add_hotel_screen.dart';
import 'package:stay_place/views/admin/manage_hotels/edit_hotel_screen.dart';
import 'package:stay_place/views/admin/manage_hotels/hotel_detail_screen.dart';
import 'package:stay_place/views/admin/manage_hotels/hotel_list_screen.dart';
import 'package:stay_place/views/admin/manage_room/room_add_screen.dart';
import 'package:stay_place/views/admin/manage_room/room_detail_screen.dart'
    as admin_room;
import 'package:stay_place/views/admin/manage_room/room_edit_screen.dart';
import 'package:stay_place/views/admin/manage_room/room_list_screen.dart';
import 'package:stay_place/views/auth/forgot_password_screen.dart';
import 'package:stay_place/views/auth/login_screen.dart';
import 'package:stay_place/views/auth/register_account_screen.dart';
import 'package:stay_place/views/auth/reset_password_screen.dart';
import 'package:stay_place/views/client/booking_form_screen.dart';
import 'package:stay_place/views/client/home_screen.dart';
import 'package:stay_place/views/client/location_map_screen.dart';
import 'package:stay_place/views/client/my_booking_screen.dart';
import 'package:stay_place/views/client/payment_history_screen.dart';
import 'package:stay_place/views/client/room_selection_screen.dart';
import 'package:stay_place/views/auth/profile_screen.dart';
import 'package:stay_place/views/auth/edit_profile_screen.dart';
import 'package:stay_place/views/client/room_detail_screen.dart';
// ... (Pastikan semua import screen lainnya sudah ada)

// ================== DEFINISI MIDDLEWARE ==================

/// Middleware untuk memastikan pengguna sudah login.
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Jika belum login, redirect ke halaman login
    // Kirim rute tujuan sebagai parameter 'next'
    return AuthService.isLoggedIn
        ? null
        : RouteSettings(name: '/auth/login?next=$route');
  }
}

/// Middleware untuk memastikan pengguna adalah admin.
class AdminMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Jika pengguna bukan admin, redirect ke halaman home
    // Kode Baru (Benar)
    return (AuthService.isLoggedIn && AuthService.loggedInUser.value!.isAdmin())
        ? null
        : const RouteSettings(name: '/home');
  }
}

// ================== FUNGSI UNTUK MENGAMBIL SEMUA RUTE ==================

List<GetPage> getPageRoute() {
  // Ganti nama fungsi agar lebih jelas
  return [
    // ---------- RUTE PUBLIK (Tanpa Middleware) ----------
    GetPage(name: '/auth/login', page: () => const LoginScreen()),
    GetPage(
        name: '/auth/register_account',
        page: () => const RegisterAccountScreen()),
    GetPage(
        name: '/auth/forgot_password',
        page: () => const ForgotPasswordScreen()),
    GetPage(
        name: '/auth/reset_password', page: () => const ResetPasswordScreen()),

    GetPage(
      name: '/profile/edit',
      page: () => const EditProfileScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/profile', // Rute umum untuk semua user
      page: () => const ProfileScreen(),
      middlewares: [
        AuthMiddleware()
      ], // Dijaga agar hanya user login yang bisa akses
    ),

    // ---------- RUTE CLIENT PANEL (Dijaga oleh AuthMiddleware) ----------
    GetPage(
        name: '/home',
        page: () => const HomeScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/room_selection',
        page: () => RoomSelectionScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/booking_form',
        page: () => BookingFormScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/my_booking',
        page: () => MyBookingScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/location_map',
        page: () => LocationMapScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/payment_history',
        page: () => PaymentHistoryScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/room_detail',
        page: () => const RoomDetailScreen(),
        middlewares: [AuthMiddleware()] // Hanya perlu login untuk melihatnya
        ),
    GetPage(
      name: '/booking_form',
      page: () => const BookingFormScreen(),
      middlewares: [AuthMiddleware()],
    ),

    // ---------- RUTE ADMIN PANEL (Dijaga oleh AuthMiddleware DAN AdminMiddleware) ----------

    // Dashboard Admin
    // Perbaikan: Rute dashboard harus spesifik untuk admin
    GetPage(
        name: '/admin/dashboard',
        page: () => const DashboardScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),

    // Manage Hotel
    GetPage(
        name: '/admin/hotel/list',
        page: () => HotelListScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: '/admin/hotel/detail',
        page: () => HotelDetailScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: '/admin/hotel/add',
        page: () => AddHotelScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: '/admin/hotel/edit',
        page: () => EditHotelScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),

    // Manage Room
    GetPage(
        name: '/admin/room/list',
        page: () => RoomListScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: '/admin/room/detail',
        page: () => admin_room.RoomDetailScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: '/admin/room/add',
        page: () => RoomAddScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: '/admin/room/edit',
        page: () => RoomEditScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),

    // Guest Management
    // Perbaikan: Ada duplikasi rute, saya hapus satu.
    GetPage(
        name: '/admin/guest/list',
        page: () => GuestListScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: '/admin/guest/add',
        page: () => AddGuestScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: '/admin/guest/edit',
        page: () => EditGuestScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),

    // Booking & Payment
    GetPage(
        name: '/admin/booking/list',
        page: () => BookingListScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: '/admin/payment',
        page: () => AdminPaymentHistoryScreen(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),

    // Rute UI/Widgets (Jika ini untuk development, admin bisa akses)
    // Jika client juga boleh akses, pindahkan ke grup Client atau cukup gunakan [AuthMiddleware()]
    // GetPage(name: '/widgets/buttons', page: () => ButtonsScreen(), middlewares: [AuthMiddleware(), AdminMiddleware()]),
    // ... dan seterusnya untuk rute UI/Extra Pages lainnya
  ];
}
