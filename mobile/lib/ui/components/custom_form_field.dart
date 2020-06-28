import 'package:flutter/material.dart';
import 'package:usermedications/ui/components/custom_text_field.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function validateFun;
  final bool withBorder;
  final bool obscureText;
  final String type;

  CustomFormField({
    this.label = '',
    this.controller,
    this.validateFun,
    this.withBorder = false,
    this.obscureText = false,
    this.type
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
        type: type
      ),
    );
  }
}
