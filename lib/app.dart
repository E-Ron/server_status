import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'navigation_screen.dart';
import 'theme/theme_manager.dart';

class App extends StatelessWidget {
  const App({super.key, required this.theme});

  final AppTheme theme;

  //if need english change to AppLocalizations.supportedLocales
  static const supportedLocales = [Locale('ru')];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeManager(theme: theme),
      child: Consumer<ThemeManager>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Server status',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: supportedLocales,
            theme: themeNotifier.theme.themeData,
            home: const NavigationScreen(),
          );
        },
      ),
    );
  }
}
