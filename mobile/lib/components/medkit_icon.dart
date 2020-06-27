import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MedkitIcon extends StatelessWidget {
  final double iconSize;
  final double opacity;

  MedkitIcon({this.iconSize = 48, this.opacity = .8});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(50, 205, 100, .2),
            blurRadius: 40,
            offset: Offset(2, 10),
          )
        ]
      ),
      child: Icon(
        FontAwesome.medkit,
        size: iconSize,
        color: Color.fromRGBO(50, 205, 100, opacity),
      )
    );
  }
}
