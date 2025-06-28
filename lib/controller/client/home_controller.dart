// lib/controller/client/home_controller.dart

import 'package:get/get.dart';
import 'package:stay_place/controller/my_controller.dart';
import 'package:stay_place/model/hotel_model.dart';
import 'package:stay_place/model/room_model.dart';

class HomeController extends MyController {
  List<HotelModel> hotel = [];
  List<RoomModel> allRooms = [];
  final List<String> destinations = [
    'New York',
    'Los Angeles',
    'Paris',
    'Tokyo',
    'London'
  ];
  final List<String> offers = [
    '10% OFF',
    'Free Breakfast',
    'Free Cancellation',
    'Early Check-in',
    'Late Check-out',
    'Free Wi-Fi'
  ];
  final List<String> featuredImages = [
    'assets/images/dummy/hotel/hotel_1.jpg',
    'assets/images/dummy/hotel/hotel_2.jpg',
    'assets/images/dummy/hotel/hotel_3.jpg',
    'assets/images/dummy/hotel/hotel_4.jpg',
    'assets/images/dummy/hotel/hotel_5.jpg',
  ];

  @override
  void onInit() {
    super.onInit();
    HotelModel.dummyList.then((value) {
      hotel = value;
      update();
    });

    // Ambil semua data kamar dan simpan di allRooms
    RoomModel.dummyList.then((value) {
      allRooms = value;
      update();
    });
  }

  // ========== FUNGSI YANG DIPERBAIKI ==========

  /// Fungsi ini dipanggil saat pengguna mengklik sebuah HOTEL.
  /// Tujuannya adalah mencari kamar milik hotel itu dan membuka detailnya.
  void goToHotelDetail(HotelModel selectedHotel) {
    // Pastikan daftar semua kamar tidak kosong
    if (allRooms.isNotEmpty) {
      // Cari kamar pertama yang hotelId-nya cocok dengan id hotel yang diklik
      RoomModel? roomOfThisHotel = allRooms.firstWhereOrNull(
        (room) => room.hotelId == selectedHotel.id,
      );

      if (roomOfThisHotel != null) {
        // Jika kamar ditemukan, kirim datanya ke halaman Room Detail
        Get.toNamed('/room_detail', arguments: roomOfThisHotel);
      } else {
        // Jika tidak ada kamar yang terhubung dengan hotel ini
        Get.snackbar(
            "Not Found", "No rooms found for ${selectedHotel.hotelName}.",
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      // Jika data kamar belum ter-load sama sekali
      Get.snackbar("Info", "Room data is loading, please try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Fungsi ini dipanggil saat pengguna mengklik sebuah KAMAR (jika ada).
  void goToRoomDetail(RoomModel selectedRoom) {
    Get.toNamed('/room_detail', arguments: selectedRoom);
  }
}
