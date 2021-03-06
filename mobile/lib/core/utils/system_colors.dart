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

  static dashboardColors({bool haveMedication = false}) {
    _setColors(
      statusBarColor: Colors.transparent,
      navigationBarColor:
          haveMedication ? Colors.white : Color.fromRGBO(50, 205, 100, 1),
      statusBarIconBrightness: Brightness.dark,
      navigationBarIconBrightness:
          haveMedication ? Brightness.dark : Brightness.light,
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
