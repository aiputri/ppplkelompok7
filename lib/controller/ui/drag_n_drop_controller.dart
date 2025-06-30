import 'package:sikilap/model/drag_n_drop.dart';
import 'package:sikilap/controller/my_controller.dart';

class DragNDropController extends MyController {
  List<DragNDropModel> contact = [];

  @override
  void onInit() {
    DragNDropModel.dummyList.then((value) {
      contact = value;
      update();
    });
    super.onInit();
  }

  void onReorder(int oldIndex, int newIndex) {
    final item = contact.removeAt(oldIndex);
    contact.insert(newIndex, item);
    update();
  }
}
