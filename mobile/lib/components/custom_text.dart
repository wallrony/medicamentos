import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isBold;
  final Color color;
  final TextAlign textAlign;

  CustomText({
    this.text = '',
    this.fontSize = 16,
    this.isBold = false,
    this.color = Colors.black,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: this.color,
      ),
      textAlign: textAlign,
    );
  }
}
