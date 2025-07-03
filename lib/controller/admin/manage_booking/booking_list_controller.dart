import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/booking_model.dart';

class BookingListController extends MyController {
  // UBAH: Nama variabel dan tambahkan isLoading
  List<BookingModel> bookingList = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    _loadBookingData();
  }

  // UBAH: Buat fungsi terpisah untuk memuat data
  void _loadBookingData() async {
    isLoading = true;
    update();

    try {
      bookingList = await BookingModel.dummyList;
    } catch (e) {
      print("Error memuat data pesanan: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  // Fungsi ini sudah ada, pastikan rutenya benar
  void goToBookingDetail(int id) {
    // TODO: Arahkan ke halaman detail pesanan dengan membawa ID
    print("Melihat detail pesanan dengan ID: $id");
    // Contoh: Get.toNamed('/admin/booking/detail', arguments: id);
  }
}
