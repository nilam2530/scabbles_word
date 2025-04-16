   import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  static const isDarkKey = "isDark";

  bool get themeValue {
    return _isDark;
  }

  set themeValue(bool value) {
    _isDark = value;
    updateThemeInPref(value);
    notifyListeners();
  }

  void updateThemeInPref(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(isDarkKey, value);
  }

  void updateThemeOnStart() async {
    var prefs = await SharedPreferences.getInstance();
    var isDarkPref = prefs.getBool(isDarkKey);

    if (isDarkPref != null) {
      _isDark = isDarkPref;
    } else {
      _isDark = false;
    }
    notifyListeners();
  }

  ThemeMode get themeMode => currentThemeMode;

  ThemeMode currentThemeMode = ThemeMode.light;

  toggleTheme(bool isDark) {
    currentThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
