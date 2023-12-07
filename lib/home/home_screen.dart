import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/auth/controller/user_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UserController controller = Get.put(UserController());
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.email!),
        actions: [
          IconButton(
            onPressed: () async {
              controller.logOutUser();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
