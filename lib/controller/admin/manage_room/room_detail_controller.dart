import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/helpers/widgets/my_text_utils.dart';

class RoomDetailController extends MyController {
  List<String> dummyTexts = List.generate(12, (index) => MyTextUtils.getDummyText(60));

  List amenities = [
    {"icon": LucideIcons.spray_can, "name": "Cuci Tekanan Tinggi"},
    {"icon": LucideIcons.wind, "name": "Vakum Interior"},
    {"icon": LucideIcons.circle_dot, "name": "Semir Ban Premium"},
    {"icon": LucideIcons.award, "name": "Tenaga Kerja Terlatih"},
    {"icon": LucideIcons.bomb, "name": "Datang Langsung ke Rumah"},
  ];
}
