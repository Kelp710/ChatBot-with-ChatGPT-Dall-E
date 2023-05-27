import 'package:flutter/material.dart';

class Temp extends ChangeNotifier {
  var _temp = 0.5;
  double get temp => _temp;

  void adjustTemp(double temp) {
    _temp = temp;
    notifyListeners();
  }
}
