import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  ThemeData get lightTheme => AppTheme.lightTheme();
  ThemeData get darkTheme => AppTheme.darkTheme();

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
