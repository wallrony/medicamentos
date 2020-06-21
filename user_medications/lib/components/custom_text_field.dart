import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final label;
  final controller;
  final obscureText;
  final validateFun;

  CustomTextField({this.label, this.controller, this.obscureText, this.validateFun});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateFun,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey[400]),
        labelText: label,
        labelStyle: TextStyle(
          color: Color.fromRGBO(50, 205, 100, .7),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
