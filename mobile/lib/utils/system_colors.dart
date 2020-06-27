import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemColors {
  static authColors() {
    _setColors(
      statusBarColor: Colors.white,
      navigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      navigationBarIconBrightness: Brightness.dark,
    );
  }

  static homeColors() {
    _setColors(
      statusBarColor: Colors.white,
      navigationBarColor: Color.fromRGBO(50, 205, 100, 1),
      statusBarIconBrightness: Brightness.dark,
      navigationBarIconBrightness: Brightness.light,
    );
  }

  static addMedicationColors() {
    _setColors(
      statusBarColor: Colors.white,
      navigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      navigationBarIconBrightness: Brightness.dark,
    );
  }

  static _setColors({
    Color statusBarColor,
    Color navigationBarColor,
    Brightness statusBarIconBrightness,
    Brightness navigationBarIconBrightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor: navigationBarColor,
      systemNavigationBarIconBrightness: navigationBarIconBrightness,
    ));
  }
}
