import 'package:flutter/material.dart';

class SettingsInteractor with ChangeNotifier {
  bool get isDarkTheme => _isDarkTheme;

  bool _isDarkTheme = false;

  void setDarkTheme(bool value) {
    _isDarkTheme = value;
    print(value);
    notifyListeners();
  }
}
