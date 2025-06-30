import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/room_model.dart';

class RoomListController extends MyController {
  List<RoomModel> room = [];

  @override
  void onInit() {
    RoomModel.dummyList.then((value) {
      room = value;
      update();
    });
    super.onInit();
  }

  void gotoAddRoom() {
    Get.toNamed('/admin/room/add');
  }

  void roomDetail() {
    Get.toNamed('/admin/room/detail');
  }

  void editRoom() {
    Get.toNamed('/admin/room/edit');
  }
}
