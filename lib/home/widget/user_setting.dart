import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/controller/user_controller.dart';

class Usersetting extends StatelessWidget {
  Usersetting({super.key});
  final UserController controller = Get.put(UserController());
  final user = FirebaseAuth.instance.currentUser;
  RxBool check = true.obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(user!.photoURL!),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Text(
                user!.displayName!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => Divider(
                color: (check.value == true) ? Colors.black : Colors.white,
                thickness: 1,
              ),
            ),
            Obx(
              () => ListTile(
                leading: Icon(
                  Icons.settings,
                  color: (check.value == true) ? Colors.black : Colors.white,
                ),
                title: const Text(
                  'User setting',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: () {
                  check.value = !check.value;
                  Get.changeTheme(
                      Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                },
                child: ListTile(
                  leading: check.value == true
                      ? const Icon(
                          Icons.dark_mode,
                          color: Colors.black,
                        )
                      : const Icon(Icons.sunny),
                  title: check.value == true
                      ? const Text(
                          'Dark Mode',
                          style: TextStyle(fontSize: 18),
                        )
                      : const Text(
                          'Light Mode',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
