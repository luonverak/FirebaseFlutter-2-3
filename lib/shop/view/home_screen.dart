import 'package:flutter/material.dart';
import 'package:flutter_firebase/shop/controller/prouct_controller.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';
import '../widget/api_item.dart';

class HomeShopScreen extends StatefulWidget {
  HomeShopScreen({super.key});

  @override
  State<HomeShopScreen> createState() => _HomeShopScreenState();
}

class _HomeShopScreenState extends State<HomeShopScreen> {
  List<ProductModel> list = [];

  getProduct() async {
    list = await APIController().getProduct();
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1 / 1.5,
          children: List.generate(
            list.length,
            (index) => itemAPI(
              list[index],
            ),
          ),
        ),
      ),
    );
  }
}
