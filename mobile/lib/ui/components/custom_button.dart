import 'package:flutter/material.dart';
import 'package:usermedications/ui/components/custom_text.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final bool reverseColors;
  final Icon icon;

  CustomIconButton({
    this.onPressed,
    this.label = '',
    this.reverseColors = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(50, 205, 100, .2),
            blurRadius: 20,
            offset: Offset(1, 1),
          )
        ],
      ),
      child: RaisedButton.icon(
        onPressed: onPressed,
        color: reverseColors ? Colors.white : Color.fromRGBO(50, 205, 100, .75),
        textColor:
            reverseColors ? Color.fromRGBO(50, 205, 100, .75) : Colors.white,
        icon: icon,
        label: CustomText(
          text: label,
          fontSize: 16,
        ),
      ),
    );
  }

  makeBorderSide(Color color) {
    return BorderSide(color: color, width: 2);
  }
}
