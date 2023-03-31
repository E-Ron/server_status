part of 'theme_manager.dart';

enum AppThemeMode {
  light,
  dark,
}

enum AppFontType {
  pixel,
  classic,
}

class AppTheme {
  static const defaultFont = AppFontType.pixel;
  static const defaultMode = AppThemeMode.light;

  static double defaultFontSize(AppFontType fontType) {
    late double fontSize;
    switch (fontType) {
      case AppFontType.pixel:
        fontSize = 14;
        break;
      case AppFontType.classic:
        fontSize = 18;
        break;
    }
    return fontSize;
  }

  AppTheme({required AppThemeMode mode, AppFontType font = defaultFont})
      : _font = font,
        _mode = mode;

  AppThemeMode _mode;
  AppFontType _font;

  AppThemeMode get mode {
    return _mode;
  }

  AppFontType get font {
    return _font;
  }

  AppTheme.light() : this(mode: AppThemeMode.light);
  AppTheme.dark() : this(mode: AppThemeMode.dark);

  static Future<AppTheme> fromStorage() async {
    ThemePreferences themePreferences = ThemePreferences();
    final font = await themePreferences.getFontType();
    final mode = await themePreferences.getThemeMode();
    return AppTheme(mode: mode, font: font);
  }

  toStorage() {}

  ThemeData get themeData {
    late ThemeData themeData;
    switch (_mode) {
      case AppThemeMode.light:
        themeData = _getLightTheme();
        break;
      case AppThemeMode.dark:
        themeData = _getDarkTheme();
        break;
    }
    return themeData;
  }

  ThemeData _getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: getFontFamily(font),
      textTheme: getTextTheme(font),
      brightness: Brightness.light,
    );
  }

  ThemeData _getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: getFontFamily(font),
      textTheme: getTextTheme(font),
      brightness: Brightness.dark,
    );
  }
}

TextTheme getTextTheme(AppFontType font) {
  late TextTheme textTheme;
  switch (font) {
    case AppFontType.pixel:
      textTheme = TextTheme();
      break;
    case AppFontType.classic:
      textTheme = TextTheme();
      break;
  }
  return textTheme;
}

String getFontFamily(AppFontType font) {
  late String fontFamily;
  switch (font) {
    case AppFontType.pixel:
      fontFamily = 'PressStart2P';
      break;
    case AppFontType.classic:
      fontFamily = 'Montserrat';
      break;
  }
  return fontFamily;
}
