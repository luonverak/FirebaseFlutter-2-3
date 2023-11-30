import 'package:flutter/material.dart';

import '../widget/input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 70,
          ),
          SizedBox(
            height: 70,
            child: Image.asset(
              'asset/icon/app.png',
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Login Account',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          InputField(
            controller: email,
            hintText: 'E-mail',
            icon: const Icon(Icons.email),
            obscureText: false,
          ),
          InputField(
            controller: password,
            hintText: 'Password',
            icon: const Icon(Icons.lock),
            sunfix: const Icon(Icons.visibility_off),
            obscureText: true,
          )
        ],
      ),
    );
  }
}