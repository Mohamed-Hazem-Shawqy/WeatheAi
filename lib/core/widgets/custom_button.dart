import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor,
      this.textColor,
      required this.width,
      required this.height});
  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(width, height),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
