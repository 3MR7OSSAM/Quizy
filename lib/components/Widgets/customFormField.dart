import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({Key? key, required this.controller, required this.onChanged, required this.hintText, this.validator, required this.obscureText, this.isCenterHint})
      : super(key: key);
  final bool obscureText;

  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;
  final bool? isCenterHint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: validator,
      obscureText: obscureText,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      controller: controller,
      onChanged: onChanged,
      textAlign: isCenterHint == null ? TextAlign.left : TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 3,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 3,
            color: Colors.white, // Change the color to what you want on focus.
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        // Add focusColor to change the cursor color when focused.
        // You can change it to any color you like.
        focusColor: Colors.white,
      ),
    );
  }
}
