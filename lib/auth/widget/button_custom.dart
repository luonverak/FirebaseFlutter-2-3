import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  ButtonCustom({
    super.key,
    required this.text,
    required this.color,
    required this.backgroundButton,
    this.icon,
    this.border,
    this.spacer,
  });
  final String text;
  final Color color;
  final Color backgroundButton;
  String? icon;
  Border? border;
  Spacer? spacer;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundButton,
          borderRadius: BorderRadius.circular(20),
          border: border,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? const Text('')
                : Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Image.asset(
                      icon!,
                      width: 45,
                    ),
                  ),
            spacer == null ? const Spacer() : spacer!,
            Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
