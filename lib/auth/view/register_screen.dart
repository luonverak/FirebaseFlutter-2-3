import 'package:flutter/material.dart';
import 'package:flutter_firebase/widget/font_colors.dart';
import 'package:get/get.dart';

import '../widget/button_custom.dart';
import '../widget/input_field.dart';
import '../widget/logo_app.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var email = TextEditingController();
  var password = TextEditingController();
  var cf_password = TextEditingController();
  RxBool check = true.obs;
  RxBool cf_check = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        primary: false,
        children: [
          const SizedBox(
            height: 60,
          ),
          logoAppCustom('Register Account'),
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
          Obx(
            () {
              return InputField(
                controller: cf_password,
                hintText: 'Confirm Password',
                icon: const Icon(Icons.lock),
                sunfix: IconButton(
                  onPressed: () {
                    cf_check.value = !cf_check.value;
                  },
                  icon: (check.value == true)
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.remove_red_eye),
                ),
                obscureText: cf_check.value,
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              if (password.text == cf_password.text) {
                print('success');
              } else {
                print('error');
              }
            },
            child: ButtonCustom(
              text: 'Create Account',
              color: Colors.white,
              backgroundButton: registerButton,
              spacer: const Spacer(
                flex: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
