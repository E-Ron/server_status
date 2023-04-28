import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:minecraft_server_status/theme/theme_manager.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(AppLocalizations.of(context)!.theme),
        ),
        ..._buildThemeVariantList(),
      ],
    );
  }

  List<Widget> _buildThemeVariantList() {
    final List<Widget> list = [];
    for (final AppThemeMode mode in AppThemeMode.values) {
      list.add(_ThemeVariant(themeMode: mode));
    }
    return list;
  }
}

class _ThemeVariant extends StatelessWidget {
  const _ThemeVariant({
    Key? key,
    required this.themeMode,
  }) : super(key: key);

  final AppThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Consumer<ThemeManager>(
          builder: (context, ThemeManager themeNotifier, child) {
        final bool isCurrentTheme = themeMode == themeNotifier.theme.mode;
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
              child: _getThemeIcon(themeMode)),
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
