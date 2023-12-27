import 'package:flutter_firebase/shop/model/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/product_api.dart';

class APIController extends GetxController {
  Future getProduct() async {
    var responce = await http.get(Uri.parse(productAPI));
    if (responce.statusCode == 200) {
      return productModelFromJson(responce.body);
    } else {
      return [];
    }
  }
}
