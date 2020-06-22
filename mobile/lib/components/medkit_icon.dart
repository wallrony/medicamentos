import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MedkitIcon extends StatelessWidget {
  final iconSize;

  MedkitIcon({this.iconSize = 48});

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
        size: double.parse(iconSize.toString()),
        color: Color.fromRGBO(50, 205, 100, .8),
      )
    );
  }
}
