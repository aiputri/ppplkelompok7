import 'package:file_picker/file_picker.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'dart:typed_data';

class EditGuestController extends MyController {
  String? fileName;
  String? filePath;
  Uint8List? fileBytes;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      fileName = result.files.single.name;

      if (result.files.single.bytes != null) {
        fileBytes = result.files.single.bytes;
      } else if (result.files.single.path != null) {
        filePath = result.files.single.path;
      }
      update();
    }
  }
}
