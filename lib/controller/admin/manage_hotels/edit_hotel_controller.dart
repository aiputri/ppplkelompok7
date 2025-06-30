import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sikilap/controller/my_controller.dart';
import 'package:sikilap/helpers/widgets/my_form_validator.dart';

enum HotelCategory {
  luxury,
  boutique,
  budget,
  resort,
  business,
}

enum RoomCategory {
  single,
  double,
  triple,
  quad,
  queen,
  king,
  tween;
}

class EditHotelController extends MyController {
  TextEditingController hotelNameController = TextEditingController(text: "Eden Stay");
  TextEditingController addressController = TextEditingController(text: "Kompl Duta Mas Fatmawati Bl D-2/15-16, Dki");
  TextEditingController countryController = TextEditingController(text: "Indonesia");
  TextEditingController stateController = TextEditingController(text: "Jakarta");
  TextEditingController cityController = TextEditingController(text: "Jakarta Selatan");
  TextEditingController zipController = TextEditingController(text: "12150");
  TextEditingController contactNumberController = TextEditingController(text: "0-217-883-6262");
  TextEditingController roomPriceController = TextEditingController(text: "\$120.00");

  QuillController quillController = QuillController.basic();
  MyFormValidator basicValidator = MyFormValidator();

  List<PlatformFile> files = [];
  List<PlatformFile> multipleFiles = [];
  bool selectMultipleFile = false;

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
