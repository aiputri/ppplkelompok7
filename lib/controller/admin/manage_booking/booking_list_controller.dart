import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/booking_model.dart';

class BookingListController extends MyController {
  List<BookingModel> booking = [];

  @override
  void onInit() {
    BookingModel.dummyList.then((value) {
      booking = value;
      update();
    });
    super.onInit();
  }

  void roomDetail() {
    Get.toNamed('/admin/room/detail');
  }

  void goToBookingDetail(int id) {}
}
