// lib/controller/admin/riwayat_pembayaran_controller.dart  (Saran nama file baru)

import 'package:sikilap/controller/my_controller.dart';
// UBAH: Import model yang benar, sesuai yang kita buat sebelumnya
import 'package:sikilap/model/payment_history_model.dart'; 

// UBAH: Nama class controller agar lebih relevan dan jelas
class RiwayatPembayaranController extends MyController {
  
  // UBAH: Nama list untuk menampung data pembayaran
  List<PembayaranModel> riwayatPembayaran = [];
  bool isLoading = true; // Tambahkan state untuk loading

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
      
      // Masukkan semua data ke dalam list
      riwayatPembayaran = data; 
      
      print("Berhasil memuat ${riwayatPembayaran.length} data riwayat pembayaran.");
      
    } catch (e) {
      // Tangani jika terjadi error saat memuat data
      print("Gagal memuat riwayat pembayaran: $e");
    } finally {
      // Set isLoading menjadi false setelah selesai, baik berhasil maupun gagal
      isLoading = false;
      update(); // Beri tahu UI untuk menampilkan data atau pesan error
    }
  }
}