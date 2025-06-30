import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/my_booking_model.dart';

class MyBookingController extends MyController {
  List<MyBookingModel> myBooking = [];

  @override
  void onInit() {
    MyBookingModel.dummyList.then((value) {
      myBooking = value;
      update();
    });
    super.onInit();
  }
}
