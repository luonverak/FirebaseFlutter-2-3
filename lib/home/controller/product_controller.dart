import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  File? file;
  Future openGallery() async {
    try {
      final chooseFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      file = File(chooseFile!.path);
    } catch (e) {
      print(e);
    }
    update();
  }

  Future openCamerea() async {
    try {
      final chooseFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      file = File(chooseFile!.path);
    } catch (e) {
      print(e);
    }
    update();
  }
}
