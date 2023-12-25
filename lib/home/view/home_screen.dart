import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/auth/controller/user_controller.dart';
import 'package:flutter_firebase/home/controller/product_controller.dart';
import 'package:flutter_firebase/home/model/prooduct_model.dart';
import 'package:flutter_firebase/home/view/add_edit_screen.dart';
import 'package:flutter_firebase/home/widget/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../widget/user_setting.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UserController controller = Get.put(UserController());
  final productController = Get.put(ProductController());
  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> product =
      FirebaseFirestore.instance.collection('pruduct_model').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Usersetting(),
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('Product note'),
        actions: [
          IconButton(
            onPressed: () => Get.to(AddAndEditScreen()),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('pruduct_model').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data!.docs[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          borderRadius: BorderRadius.circular(10),
                          onPressed: (context) => Get.to(
                            AddAndEditScreen(
                              docId: snapshot.data!.docs[index].id,
                              productModel: ProductModel(
                                id: item.get('id'),
                                name: item.get('name'),
                                price: item.get('price'),
                                image: item.get('image'),
                                time: item.get('time'),
                              ),
                            ),
                          ),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          borderRadius: BorderRadius.circular(10),
                          onPressed: (context) async {
                            await productController
                                .deleteProduct(snapshot.data!.docs[index].id);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 90,
                      child: Card(
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    snapshot.data!.docs[index].get('image'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  snapshot.data!.docs[index].get('name'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Price ${snapshot.data!.docs[index].get('price')} \$',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  snapshot.data!.docs[index].get('time'),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Icon(Icons.error, color: Colors.red));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
