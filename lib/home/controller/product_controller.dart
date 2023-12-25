import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/prooduct_model.dart';

class ProductController extends GetxController {
  File? file;
  late String imageURL = "";
  CollectionReference product =
      FirebaseFirestore.instance.collection('pruduct_model');

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

  late Reference ref;

  Future uploadFile(XFile files) async {
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final refsRoot = FirebaseStorage.instance.ref();
    final refsImage = refsRoot.child('product_image');
    final refsUpload = refsImage.child('$time-${files.name}');
    try {
      await refsUpload.putFile(File(file!.path));
      imageURL = await refsUpload.getDownloadURL();
    } catch (e) {
      print(e);
    }
  }

  Future addProduct(ProductModel model) async {
    await product
        .add(model.fromJson())
        .then(
          (value) => Get.snackbar('Success', 'Item add success'),
        )
        .catchError(
          (error) => print("Failed to add products: $error"),
        );
  }

  Future<void> deleteProduct(String id) async {
    await product.doc(id).delete();
    Get.snackbar('Success', 'Item was remove');
  }

  Future updateProduct(ProductModel model, String id) async {
    await product
        .doc(id)
        .update(model.fromJson())
        .then(
          (value) => Get.snackbar('Success', 'Item add success'),
        )
        .catchError(
          (error) => print("Failed to update user: $error"),
        );
  }
}
