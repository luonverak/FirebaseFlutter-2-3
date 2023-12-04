import 'package:flutter/material.dart';

Widget logoAppCustom(String title) {
  return Column(
    children: [
      SizedBox(
        height: 70,
        child: Image.asset(
          'asset/icon/app.png',
        ),
      ),
      const SizedBox(
        height: 20,
      ),
       Text(
        title,
        style:const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      )
    ],
  );
}
