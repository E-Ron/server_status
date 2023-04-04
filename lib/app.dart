import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation_screen.dart';
import 'theme/theme_manager.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.theme}) : super(key: key);

  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeManager(theme: theme),
      child: Consumer<ThemeManager>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Minecraft server status',
            theme: themeNotifier.theme.themeData,
            home: const NavigationScreen(),
          );
        },
      ),
    );
  }
}
