import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  File? file;
  late Reference storageRef;
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

  Future uploadFile(File files) async {
    final path = "pic/$files";
    storageRef = FirebaseStorage.instance.ref().child(path);
    storageRef.putFile(files);
  }
}
