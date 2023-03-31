import 'package:flutter/material.dart';
import 'theme_preferences.dart';
part 'theme.dart';

class ThemeManager with ChangeNotifier {
  ThemeManager({required theme}) : _theme = theme;

  final AppTheme _theme;
  final ThemePreferences _preferences = ThemePreferences();

  AppTheme get theme {
    return _theme;
  }

  setThemeMode(AppThemeMode mode) async {
    _theme._mode = mode;
    _preferences.setThemeMode(mode);
    notifyListeners();
  }

  setThemeFont(AppFontType font) async {
    _theme._font = font;
    notifyListeners();
  }
}
