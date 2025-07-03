// lib/helpers/services/booking_service.dart

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikilap/helpers/services/auth_services.dart';
import 'package:sikilap/helpers/services/payment_service.dart';
import 'package:sikilap/model/hotel_model.dart';
import 'package:sikilap/model/my_booking_model.dart';
import 'package:sikilap/model/payment_history_model.dart'; // Ganti dengan path model pembayaran yang benar
import 'package:sikilap/model/room_model.dart'; // Pastikan path ini sesuai dengan lokasi RoomModel

class BookingService extends GetxService {
  final RxList<MyBookingModel> bookings = <MyBookingModel>[].obs;
  final PaymentService paymentService = Get.find<PaymentService>();

  @override
  void onInit() {
    super.onInit();
    MyBookingModel.dummyList.then((dummyData) {
      bookings.assignAll(dummyData);
    });
  }

  /// Membuat pesanan baru dan tagihan pembayaran yang terkait.
  void createNewBooking({
    required HotelModel hotel,
    required RoomModel room,
    required String bookingDate,
    required String bookingTime,
    required String address,
    required String vehicleType,
  }) {
    final userName = AuthService.loggedInUser.value?.name ?? 'Unknown User';
    final jadwalLayanan = "$bookingDate - $bookingTime";
    final uniqueBookingId = 'B${1000 + bookings.length + 1}';
    final uniqueTransactionId = 'TX${DateTime.now().millisecondsSinceEpoch}';

    // 1. Buat objek PESANAN baru
    final newBooking = MyBookingModel(
      bookings.length + 1, // id (int)
      uniqueBookingId, // bookingID (String)
      userName, // guestName (String)
      hotel.hotelName, // hotelName (String) -> Nama Mitra
      room.roomType, // roomType (String) -> Nama Layanan
      jadwalLayanan, // checkInDate (String) -> Jadwal Layanan
      'N/A', // checkOutDate (String) -> Tidak Terpakai
      'IDR', // currency (String)
      'Belum Lunas', // paymentStatus (String)
      'Menunggu Pembayaran', // bookingStatus (String) -> Status yang benar
      DateFormat('yyyy-MM-dd').format(DateTime.now()), // bookingDate (String)
      vehicleType, // specialRequests (String) -> Jenis Kendaraan
      'Menunggu Pembayaran', // paymentMethod (String)
      1, // numberOfGuest (int)
      room.pricePerNight, // totalPrice (double)
    );

    // 2. Buat objek TAGIHAN baru
    final newPayment = PembayaranModel(
      paymentService.payments.length + 1, // id (int)
      uniqueTransactionId, // idTransaksi (String)
      uniqueBookingId, // kodePesanan (String) - SAMA DENGAN bookingID
      userName, // namaPelanggan (String)
      room.pricePerNight, // jumlahDibayar (double)
      'IDR', // mataUang (String)
      'Belum Dipilih', // metodePembayaran (String)
      'Belum Lunas', // statusPembayaran (String)
      DateTime.now(), // tanggalPembayaran (DateTime)
      'Tagihan untuk layanan ${room.roomType}', // catatan (String)
      '', // Tambahkan argumen ke-11 sesuai kebutuhan, misal: '' (String kosong) atau nilai default lain
    );

    // 3. Tambahkan ke masing-masing service
    bookings.insert(0, newBooking);
    paymentService.createNewPayment(newPayment);

    print(
        "Pesanan & Tagihan baru telah dibuat dengan ID Pesanan: $uniqueBookingId");
  }

  /// Fungsi ini dipanggil oleh PaymentService setelah pembayaran berhasil.
  void confirmBookingStatus(String bookingId) {
    try {
      var booking = bookings.firstWhere((b) => b.bookingID == bookingId);

      // Ubah status pesanan menjadi Confirmed/Selesai
      booking.bookingStatus = 'Confirmed';
      booking.paymentStatus = 'Lunas';

      // Refresh list agar UI di halaman "Pesanan Saya" ikut update
      bookings.refresh();

      print("Status Pesanan $bookingId telah diubah menjadi Confirmed.");
    } catch (e) {
      print("Pesanan $bookingId tidak ditemukan untuk diubah statusnya.");
    }
  }

  void confirmBooking(String kodePesanan) {
    // TODO: Implement logic to confirm booking by kodePesanan
    // For now, just print or update your state as needed
    print('Booking confirmed for $kodePesanan');
  }
}
