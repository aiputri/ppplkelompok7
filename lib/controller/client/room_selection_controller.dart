// lib/controller/client/room_selection_controller.dart

import 'package:get/get.dart';
// Ganti path model dengan yang benar di proyekmu
import 'package:sikilap/model/hotel_model.dart';
import 'package:sikilap/model/room_model.dart';
import 'package:sikilap/controller/my_controller.dart';

class RoomSelectionController extends MyController {
  final HotelModel? hotel; // Untuk menyimpan data Mitra yang dipilih
  List<RoomModel> allRooms = [];
  List<RoomModel> rooms = []; // Kamar yang sudah difilter untuk Mitra ini

  // Constructor yang dimodifikasi untuk menerima data Mitra
  RoomSelectionController(this.hotel);

  @override
  void onInit() {
    super.onInit();
    _loadAndFilterRooms();
  }

  Future<void> _loadAndFilterRooms() async {
    // Pastikan kita punya data Mitra
    if (hotel != null) {
      // Ambil semua data layanan
      allRooms = await RoomModel.dummyList;

      // Filter layanan berdasarkan ID Mitra
      rooms = allRooms.where((room) => room.hotelId == hotel!.id).toList();

      // Update UI untuk menampilkan layanan yang sudah difilter
      update();
    }
  }

  void onFavouriteToggle(RoomModel room) {
    room.isFavourite = !room.isFavourite;
    update();
  }

  // FUNGSI BARU UNTUK NAVIGASI
  void goToBookingForm(RoomModel selectedRoom) {
    // Siapkan data Mitra dan Layanan untuk dikirim
    Map<String, dynamic> bookingData = {
      'hotel': hotel,
      'room': selectedRoom,
    };
    // Arahkan ke form pemesanan dengan membawa data
    Get.toNamed('/booking_form', arguments: bookingData);
  }
}
