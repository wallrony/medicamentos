import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavUtils {
  static push({BuildContext context, Widget page, bool replace = false}) {
    if (replace) {
      return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false,
      );
    } else {
      return Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }));
    }
  }

  static void pop(BuildContext context) => Navigator.of(context).pop();
}