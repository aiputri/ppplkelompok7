// lib/controller/client/payment_history_controller.dart (Saran nama file)

import 'package:sikilap/controller/my_controller.dart';
// UBAH: Import model yang benar, yaitu model pembayaran Sikilap
import 'package:sikilap/model/payment_history_model.dart'; 

// Nama class tetap, sesuai dengan nama file UI
class PaymentHistoryController extends MyController {
  
  // UBAH: Nama list dan tipe datanya agar sesuai dengan model
  List<PembayaranModel> riwayatPembayaran = [];
  bool isLoading = true;

  get paymentHistory => null; // Tambahkan state untuk loading

  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi untuk memuat data
    _loadRiwayatPembayaran();
  }

  // Buat fungsi terpisah untuk memuat data agar lebih rapi
  void _loadRiwayatPembayaran() async {
    // Set isLoading menjadi true saat mulai memuat
    isLoading = true;
    update(); // Beri tahu UI untuk menampilkan loading indicator

    try {
      // Panggil dummyList dari model yang benar
      List<PembayaranModel> data = await PembayaranModel.dummyList;
      
      // Masukkan semua data ke dalam list.
      // Untuk Klien, mungkin Anda ingin memfilter berdasarkan ID user yang login,
      // tapi untuk sekarang kita tampilkan semua data dummy.
      riwayatPembayaran = data; 
      
      print("Berhasil memuat ${riwayatPembayaran.length} data riwayat pembayaran untuk klien.");
      
    } catch (e) {
      // Tangani jika terjadi error saat memuat data
      print("Gagal memuat riwayat pembayaran klien: $e");
    } finally {
      // Set isLoading menjadi false setelah selesai, baik berhasil maupun gagal
      isLoading = false;
      update(); // Beri tahu UI untuk menampilkan data atau pesan error
    }
  }
}