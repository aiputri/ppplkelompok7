// lib/helpers/services/payment_service.dart

import 'package:get/get.dart';
import 'package:sikilap/model/payment_history_model.dart';

class PaymentService extends GetxService {
  final RxList<PembayaranModel> payments = <PembayaranModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    PembayaranModel.dummyList.then((dummy) => payments.assignAll(dummy));
  }

  // Fungsi untuk menambahkan tagihan baru
  void createNewPayment(PembayaranModel payment) {
    payments.insert(0, payment);
  }

  // Fungsi untuk mengubah status pembayaran menjadi LUNAS
  void markAsPaid(String bookingId, String paymentMethod) {
    try {
      // Cari pembayaran berdasarkan kode pesanan
      var payment = payments.firstWhere((p) => p.kodePesanan == bookingId);
      payment.statusPembayaran = 'Lunas';
      payment.metodePembayaran = paymentMethod; // Contoh: 'Transfer Bank'

      // Refresh list agar UI update
      payments.refresh();
      print("Pembayaran untuk pesanan $bookingId berhasil.");
    } catch (e) {
      print("Tagihan untuk pesanan $bookingId tidak ditemukan.");
    }
  }
}
