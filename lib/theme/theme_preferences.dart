import 'package:shared_preferences/shared_preferences.dart';

import 'package:minecraft_server_status/utils/enum.dart';
import 'theme_manager.dart';

class ThemePreferences {
  ThemePreferences({required this.prefs});

  final Future<SharedPreferences> prefs;

  static const themeModeKey = 'theme_mode';
  static const fontTypeKey = 'font_type';

  Future<void> setThemeMode(AppThemeMode themeMode) async {
    final SharedPreferences prefs = await this.prefs;
    await prefs.setString(themeModeKey, enumToString(themeMode));
  }

  Future<AppThemeMode> fetchThemeMode() async {
    final SharedPreferences prefs = await this.prefs;
    final themeModeString = prefs.getString(themeModeKey);
    return _themeModeFromString(themeModeString);
  }

  AppThemeMode _themeModeFromString(String? themeModeString) {
    final AppThemeMode? themeMode = enumFromString(
      themeModeString,
      AppThemeMode.values,
    );
    return themeMode ?? AppTheme.defaultMode;
  }

  Future<void> setFontType(AppFontType fontType) async {
    final SharedPreferences prefs = await this.prefs;
    await prefs.setString(fontTypeKey, enumToString(fontType));
  }

  Future<AppFontType> fetchFontType() async {
    final SharedPreferences prefs = await this.prefs;
    final fontTypeString = prefs.getString(fontTypeKey);
    return _fontTypeFromString(fontTypeString);
  }

  AppFontType _fontTypeFromString(String? themeModeString) {
    final AppFontType? themeMode = enumFromString(
      themeModeString,
      AppFontType.values,
    );
    return themeMode ?? AppTheme.defaultFont;
  }
}
