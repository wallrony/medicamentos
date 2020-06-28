import 'package:flutter/material.dart';
import 'package:usermedications/core/controller/facade.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _running = false;
  bool get running => _running;

  final Facade _facade = Facade();
  Facade get facade => _facade;

  void setRunning(bool value) {
    _running = value;
    notifyListeners();
  }
}