import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/auth/controller/user_controller.dart';
import 'package:flutter_firebase/home/widget/colors.dart';
import 'package:get/get.dart';

import '../widget/user_setting.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UserController controller = Get.put(UserController());
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Usersetting(),
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('Dating note'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
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
