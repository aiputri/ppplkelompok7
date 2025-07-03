// lib/controller/client/home_controller.dart

import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/hotel_model.dart';
import 'package:sikilap/model/room_model.dart';

class HomeController extends MyController {
  List<HotelModel> hotel = []; // Daftar Mitra
  List<RoomModel> allRooms = []; // Daftar semua Layanan

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
    RoomModel.dummyList.then((value) {
      allRooms = value;
      update();
    });
  }

  /// Fungsi ini dipanggil saat pengguna mengklik sebuah MITRA.
  /// Tujuannya adalah langsung membuka detail untuk SATU LAYANAN UNGGULAN dari mitra itu.
  void goToMitraDetail(HotelModel selectedMitra) {
    if (allRooms.isNotEmpty) {
      // Cari layanan pertama yang dimiliki oleh mitra yang diklik
      RoomModel? layananUnggulan = allRooms.firstWhereOrNull(
        (layanan) => layanan.hotelId == selectedMitra.id,
      );

      if (layananUnggulan != null) {
        // Jika ditemukan, langsung kirim ke halaman detail layanan
        Get.toNamed('/room_detail', arguments: layananUnggulan);
      } else {
        Get.snackbar("Info", "Mitra ini belum memiliki layanan.",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  /// Fungsi ini dipanggil saat pengguna mengklik sebuah LAYANAN UNGGULAN.
  /// Tujuannya adalah membuka halaman PILIH LAYANAN untuk mitra yang memiliki layanan itu.
  void goToLayananSelection(RoomModel selectedLayanan) {
    if (hotel.isNotEmpty) {
      // Cari mitra yang memiliki layanan ini
      HotelModel? mitraPemilik = hotel.firstWhereOrNull(
        (mitra) => mitra.id == selectedLayanan.hotelId,
      );

      if (mitraPemilik != null) {
        // Jika ditemukan, kirim data mitra ke halaman pemilihan layanan
        Get.toNamed('/room_selection', arguments: mitraPemilik);
      } else {
        Get.snackbar("Error", "Data mitra untuk layanan ini tidak ditemukan.",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
