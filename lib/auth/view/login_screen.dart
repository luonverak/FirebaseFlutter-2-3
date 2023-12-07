import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/auth/controller/user_controller.dart';
import 'package:flutter_firebase/auth/model/user_model.dart';
import 'package:flutter_firebase/auth/view/register_screen.dart';
import 'package:flutter_firebase/widget/font_colors.dart';
import 'package:get/get.dart';

import '../widget/button_custom.dart';
import '../widget/input_field.dart';
import '../widget/logo_app.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final UserController controller = Get.put(UserController());
  var email = TextEditingController();
  var password = TextEditingController();
  RxBool check = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        primary: false,
        children: [
          const SizedBox(
            height: 60,
          ),
          logoAppCustom('Login Account'),
          const SizedBox(
            height: 20,
          ),
          InputField(
            controller: email,
            hintText: 'E-mail',
            icon: const Icon(Icons.email),
            obscureText: false,
          ),
          Obx(
            () {
              return InputField(
                controller: password,
                hintText: 'Password',
                icon: const Icon(Icons.lock),
                sunfix: IconButton(
                  onPressed: () {
                    check.value = !check.value;
                  },
                  icon: (check.value == true)
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.remove_red_eye),
                ),
                obscureText: check.value,
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () async {
              controller.loginAccount(
                UserModel(
                  email: email.text,
                  password: password.text.trim(),
                ),
              );
            },
            child: ButtonCustom(
              text: 'Login',
              color: Colors.white,
              backgroundButton: buttonColor,
              spacer: const Spacer(
                flex: 2,
              ),
            ),
          ),
          const Text(
            'or',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          ButtonCustom(
            text: 'Connect with facebook',
            color: Colors.white,
            backgroundButton: fbButton,
            icon: 'asset/icon/facebook.png',
          ),
          GestureDetector(
            onTap: () async {
              await controller.signInWithGoogle();
            },
            child: ButtonCustom(
              text: 'Connect with Google',
              color: Colors.black,
              backgroundButton: googleButton,
              icon: 'asset/icon/new.png',
              border: Border.all(
                width: 1,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CupertinoButton(
        child: const Text(
          'Register Account',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Get.to(RegisterScreen());
        },
      ),
    );
  }
}
