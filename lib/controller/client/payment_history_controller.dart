import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/payment_history_model.dart';

class PaymentHistoryController extends MyController {
  List<PaymentHistoryModel> paymentHistory = [];

  @override
  void onInit() {
    PaymentHistoryModel.dummyList.then((value) {
      paymentHistory = value.sublist(0, 10);
      update();
    });
    super.onInit();
  }
}
