// lib/controller/client/room_detail_controller.dart

import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/hotel_model.dart'; // <-- IMPORT BARU
import 'package:sikilap/model/room_model.dart';

class RoomDetailController extends MyController {
  final RoomModel? room;

  // Kita akan butuh data hotel juga, jadi kita cari dulu
  HotelModel? hotel;

  RoomDetailController(this.room);

  @override
  void onInit() {
    super.onInit();
    _findHotelForThisRoom();
  }

  Future<void> _findHotelForThisRoom() async {
    if (room != null) {
      // Ambil semua data hotel
      List<HotelModel> allHotels = await HotelModel.dummyList;
      // Cari hotel yang ID-nya cocok dengan hotelId di kamar
      hotel = allHotels.cast<HotelModel?>().firstWhere(
            (h) => h != null && h.id == room!.hotelId,
            orElse: () => null,
          );
      update();
    }
  }

  // FUNGSI BARU UNTUK NAVIGASI
  void goToRoomSelection() {
    // Pastikan kita punya data Mitra sebelum navigasi
    if (hotel != null) {
      // Arahkan ke halaman pemilihan layanan dan kirim data Mitra
      Get.toNamed('/room_selection', arguments: hotel);
    } else {
      Get.snackbar("Error", "Informasi mitra tidak ditemukan.");
    }
  }
}
