import 'package:minecraft_server_status/theme/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:minecraft_server_status/utils/enum.dart';

class ThemePreferences {
  ThemePreferences({required this.prefs});

  final Future<SharedPreferences> prefs;

  static const themeModeKey = "theme_mode";
  static const fontTypeKey = "font_type";

  void setThemeMode(AppThemeMode themeMode) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setString(themeModeKey, enumToString(themeMode));
  }

  Future<AppThemeMode> getThemeMode() async {
    SharedPreferences prefs = await this.prefs;
    final themeModeString = prefs.getString(themeModeKey);
    return _themeModeFromString(themeModeString);
  }

  AppThemeMode _themeModeFromString(String? themeModeString) {
    AppThemeMode? themeMode = enumFromString(
      themeModeString,
      AppThemeMode.values,
    );
    return themeMode ?? AppTheme.defaultMode;
  }

  void setFontType(AppFontType fontType) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setString(fontTypeKey, enumToString(fontType));
  }

  Future<AppFontType> getFontType() async {
    SharedPreferences prefs = await this.prefs;
    final fontTypeString = prefs.getString(fontTypeKey);
    return _fontTypeFromString(fontTypeString);
  }

  AppFontType _fontTypeFromString(String? themeModeString) {
    AppFontType? themeMode = enumFromString(
      themeModeString,
      AppFontType.values,
    );
    return themeMode ?? AppTheme.defaultFont;
  }
}
