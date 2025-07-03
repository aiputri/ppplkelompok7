import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/my_booking_model.dart';
import 'package:sikilap/helpers/services/booking_service.dart';
import 'package:get/get.dart';

class MyBookingController extends MyController {
  final BookingService bookingService = Get.find();
  List<MyBookingModel> get myBooking => bookingService.bookings;
}
