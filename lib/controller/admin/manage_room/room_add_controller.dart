import 'package:file_picker/file_picker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/helpers/widgets/my_form_validator.dart';

enum RoomCategory {
  single,
  double,
  triple,
  quad,
  queen,
  king,
  tween;
}

class RoomAddController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  List<PlatformFile> files = [];
  List<PlatformFile> multipleFiles = [];
  bool selectMultipleFile = false;

  QuillController quillController = QuillController.basic();

  FileType type = FileType.any;

  Future<void> pickFiles() async {
    var result = await FilePicker.platform.pickFiles(allowMultiple: selectMultipleFile, type: type);
    if (result?.files.isNotEmpty ?? false) {
      files.addAll(result!.files);
    }
    update();
  }

  void removeFile(PlatformFile file) {
    files.remove(file);
    update();
  }
}
