import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/auth/controller/user_controller.dart';
import 'package:flutter_firebase/home/view/add_edit_screen.dart';
import 'package:flutter_firebase/home/widget/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../widget/user_setting.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UserController controller = Get.put(UserController());
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
      body: StreamBuilder<QuerySnapshot>(
        stream: product,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        onPressed: (context) => Get.to(
                          AddAndEditScreen(productModel: null),
                        ),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        onPressed: (context) {},
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
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  data['image'],
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
                                data['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                data['price'].toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                data['time'],
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
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
