import 'package:flutter/material.dart';

TextField authInput({
  required TextEditingController controller,
  required bool isPassword,
  required String labelText 
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(),
    ),
  );
}