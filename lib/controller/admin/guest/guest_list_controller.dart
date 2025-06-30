import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/guest_model.dart';

class GuestListController extends MyController {
  List<GuestModel> guest = [];

  @override
  void onInit() {
    GuestModel.dummyList.then((value) {
      guest = value;
      update();
    });
    super.onInit();
  }

  void editGuest(int id) {
    Get.toNamed('/admin/guest/edit');
  }

  void addGuest(int id) {
    Get.toNamed('/admin/guest/add');
  }
}
