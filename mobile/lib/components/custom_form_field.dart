import 'package:flutter/material.dart';
import 'package:usermedications/components/custom_text_field.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function validateFun;
  final bool withBorder;
  final bool obscureText;

  CustomFormField({
    this.label = '',
    this.controller,
    this.validateFun,
    this.withBorder,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        border: withBorder
            ? Border(
                bottom: BorderSide(
                  color: Colors.grey[100],
                  style: BorderStyle.solid,
                ),
              )
            : null,
      ),
      child: CustomTextField(
        label: label,
        obscureText: obscureText,
        validateFun: validateFun,
        controller: controller,
      ),
    );
  }
}
