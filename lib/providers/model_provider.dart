import 'package:flutter/material.dart';

class ModelVersion extends ChangeNotifier {
  var _model = 'gpt-4-0314';
  String get model => _model;

  void changeModel(String model) {
    _model = model;
    notifyListeners();
  }
}
