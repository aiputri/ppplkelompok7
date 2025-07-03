// lib/controller/client/payment_history_controller.dart

import 'package:sikilap/controller/my_controller.dart';
// Ganti dengan path model yang benar di proyekmu
import 'package:sikilap/model/payment_history_model.dart';

class PaymentHistoryController extends MyController {
  // GUNAKAN NAMA INI agar konsisten dengan screen
  List<PembayaranModel> paymentHistory = [];
  bool isLoading = true;

  // HAPUS getter yang menyebabkan error
  // get paymentHistory => null;

  @override
  void onInit() {
    super.onInit();
    _loadPaymentHistory();
  }

  void _loadPaymentHistory() async {
    isLoading = true;
    update();

    try {
      // Panggil dummyList dari model yang benar
      List<PembayaranModel> data = await PembayaranModel.dummyList;
      paymentHistory = data;
      print(
          "Berhasil memuat ${paymentHistory.length} data riwayat pembayaran.");
    } catch (e) {
      print("Gagal memuat riwayat pembayaran: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
