import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/home/controller/product_controller.dart';
import 'package:flutter_firebase/home/model/prooduct_model.dart';
import 'package:get/get.dart';
import '../widget/input_field.dart';
import '../widget/colors.dart';

class AddAndEditScreen extends StatelessWidget {
  AddAndEditScreen({super.key, this.productModel});
  ProductModel? productModel;
  var productName = TextEditingController();
  var productPrice = TextEditingController();
  final controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          (productModel == null) ? 'Add product' : 'Edit product',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.uploadFile(controller.file!);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  GetBuilder<ProductController>(
                    init: ProductController(),
                    builder: (controller) {
                      return Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(100),
                          image: controller.file == null
                              ? const DecorationImage(
                                  image: AssetImage('asset/image/9212299.jpg'),
                                )
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(controller.file!),
                                ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 15,
                    bottom: 18,
                    child: GestureDetector(
                      onTap: () {
                        showAdaptiveActionSheet(
                          context: context,
                          androidBorderRadius: 30,
                          actions: [
                            BottomSheetAction(
                              title: const Text('Choose gallery'),
                              onPressed: (context) async {
                                await controller
                                    .openGallery()
                                    .whenComplete(() => Navigator.pop(context));
                              },
                            ),
                            BottomSheetAction(
                              title: const Text('Take photo'),
                              onPressed: (context) async {
                                await controller
                                    .openCamerea()
                                    .whenComplete(() => Navigator.pop(context));
                              },
                            ),
                          ],
                          cancelAction: CancelAction(
                            title: const Text('Cancel'),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 98, 98, 98),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                controller: productName,
                hintText: 'Enter product name',
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                controller: productPrice,
                hintText: 'Enter product description',
                maxLine: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
