import 'package:flutter/material.dart';
import 'package:flutter_firebase/widget/font_colors.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.sunfix,
    required this.obscureText,
  });
  var controller = TextEditingController();
  final String hintText;
  final Icon icon;
  late Icon? sunfix;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: inputColor,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
            color: textColor,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            prefixIcon: icon,
            suffixIcon: sunfix,
          ),
        ),
      ),
    );
  }
}
