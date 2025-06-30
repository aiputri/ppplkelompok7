import 'package:get/get.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/model/room_model.dart';

class RoomSelectionController extends MyController {
  List<RoomModel> room = [];

  @override
  void onInit() {
    RoomModel.dummyList.then((value) {
      room = value;
      update();
    });
    super.onInit();
  }

  void onFavouriteToggle(RoomModel room) {
    room.isFavourite = !room.isFavourite;
    update();
  }

  void goToRoomDetail() {
    Get.toNamed('/admin/room/detail');
  }
}
