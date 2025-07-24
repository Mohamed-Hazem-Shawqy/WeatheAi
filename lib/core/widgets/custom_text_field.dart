import 'package:flutter/material.dart';
import 'package:weather_ai/core/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controller, required this.obscureText, this.prefixIcon});
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * .85,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        obscureText: obscureText,
        decoration: InputDecoration(prefixIcon:prefixIcon ,
          fillColor: AppColors.lightBlue,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.lightBlue,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.lightBlue,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightBlue, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
