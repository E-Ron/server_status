import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minecraft_server_status/theme/theme_manager.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({Key? key}) : super(key: key);

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Тема '),
        ..._buildThemeVariantList(),
      ],
    );
  }

  List<Widget> _buildThemeVariantList() {
    List<Widget> list = [];
    for (AppThemeMode mode in AppThemeMode.values) {
      list.add(ThemeVariant(themeMode: mode));
    }
    return list;
  }
}

class ThemeVariant extends StatelessWidget {
  const ThemeVariant({
    Key? key,
    required this.themeMode,
    this.hasIcon = true,
  }) : super(key: key);

  final AppThemeMode themeMode;
  final bool hasIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Consumer<ThemeManager>(
          builder: (context, ThemeManager themeNotifier, child) {
        bool isCurrentTheme = themeMode == themeNotifier.theme.mode;
        return GestureDetector(
          onTap: isCurrentTheme
              ? null
              : () {
                  themeNotifier.setThemeMode(themeMode);
                },
          child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: isCurrentTheme
                    ? Border.all(color: Colors.lightBlueAccent, width: 1)
                    : null,
                color: _getThemeBackgroundColor(themeMode),
                shape: BoxShape.circle,
              ),
              child: hasIcon ? _getThemeIcon(themeMode) : null),
        );
      }),
    );
  }

  Color _getThemeBackgroundColor(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return Colors.white;
      case AppThemeMode.dark:
        return Colors.black;
    }
  }

  Icon _getThemeIcon(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return const Icon(
          Icons.light_mode,
          color: Colors.black,
        );
      case AppThemeMode.dark:
        return const Icon(
          Icons.dark_mode,
          color: Colors.white,
        );
    }
  }
}
