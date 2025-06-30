import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/payment_history_model.dart';

class AdminPaymentHistoryController extends MyController {
  List<PaymentHistoryModel> paymentHistory = [];

  @override
  void onInit() {
    PaymentHistoryModel.dummyList.then((value) {
      paymentHistory = value.sublist(11, 20);
      update();
    });
    super.onInit();
  }
}
