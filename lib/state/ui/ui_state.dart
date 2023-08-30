import 'package:flutter/material.dart';

class UiModel with ChangeNotifier {
  double _scale = 1;

  UiModel(this._scale);

  double getScale() => _scale;

  void setScale(double newScale) {
    _scale = newScale;
    print(newScale);
    notifyListeners();
  }
}
