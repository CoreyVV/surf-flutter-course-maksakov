import 'package:flutter/material.dart';

class SettingsInteractor with ChangeNotifier {
  bool get isDarkTheme => _isDarkTheme;

  set isDarkTheme(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }

  bool _isDarkTheme = false;
}
