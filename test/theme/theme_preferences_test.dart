import 'package:flutter_test/flutter_test.dart';
import 'package:minecraft_server_status/theme/theme_manager.dart';
import 'package:minecraft_server_status/theme/theme_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Theme preferences', () {
    const defaultFontTypeRaw = 'classic';

    test('Get empty preferences', () async {
      SharedPreferences.setMockInitialValues({});

      ThemePreferences themePreferences = ThemePreferences(
        prefs: SharedPreferences.getInstance(),
      );

      final AppFontType fontType = await themePreferences.fetchFontType();

      expect(fontType, AppTheme.defaultFont);
    });

    test('Get preferences', () async {
      SharedPreferences.setMockInitialValues({
        ThemePreferences.fontTypeKey: defaultFontTypeRaw,
      });

      final themePreferences = ThemePreferences(
        prefs: SharedPreferences.getInstance(),
      );

      final AppFontType fontType = await themePreferences.fetchFontType();

      expect(fontType, AppFontType.classic);
    });

    test('Set preferences', () async {
      SharedPreferences.setMockInitialValues({});

      final themePreferences = ThemePreferences(
        prefs: SharedPreferences.getInstance(),
      );

      themePreferences.setFontType(AppFontType.classic);

      await Future.delayed(const Duration(microseconds: 200));

      final prefs = await SharedPreferences.getInstance();
      final fontTypeRaw = prefs.get(ThemePreferences.fontTypeKey);

      expect(fontTypeRaw.runtimeType, String);
      expect(fontTypeRaw, 'classic');
    });

    test('Replace preferences', () async {
      SharedPreferences.setMockInitialValues({
        ThemePreferences.fontTypeKey: defaultFontTypeRaw,
      });

      final themePreferences = ThemePreferences(
        prefs: SharedPreferences.getInstance(),
      );

      themePreferences.setFontType(AppFontType.classic);

      final prefs = await SharedPreferences.getInstance();
      final fontTypeRaw = prefs.get(ThemePreferences.fontTypeKey);

      expect(fontTypeRaw.runtimeType, String);
      expect(fontTypeRaw, 'classic');
    });
  });
}
