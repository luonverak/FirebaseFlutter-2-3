import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/home/model/prooduct_model.dart';
import '../widget/input_field.dart';
import '../widget/colors.dart';

class AddAndEditScreen extends StatelessWidget {
  AddAndEditScreen({super.key, this.productModel});
  ProductModel? productModel;
  var name = TextEditingController();
  var price = TextEditingController();
  File? _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          (productModel != null) ? 'Add product' : 'Edit product',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(100),
                      image: _file == null
                          ? const DecorationImage(
                              image: AssetImage('asset/image/9212299.jpg'))
                          : DecorationImage(image: FileImage(_file!))),
                ),
                Positioned(
                  right: 15,
                  bottom: 18,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 218, 218, 218),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.camera_alt,
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
              controller: name,
              hintText: 'Enter product name',
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              controller: price,
              hintText: 'Enter product name',
              maxLine: 10,
            ),
          ],
        ),
      ),
    );
  }
}
