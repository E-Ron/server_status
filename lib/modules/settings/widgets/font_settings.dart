import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:minecraft_server_status/theme/theme_manager.dart';

class FontSettings extends StatefulWidget {
  const FontSettings({super.key});

  @override
  State<FontSettings> createState() => _FontSettingsState();
}

class _FontSettingsState extends State<FontSettings> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(AppLocalizations.of(context)!.font),
        ),
        ..._buildFontVariantList(),
      ],
    );
  }

  List<Widget> _buildFontVariantList() {
    List<Widget> list = [];
    for (AppFontType font in AppFontType.values) {
      list.add(FontVariant(fontType: font));
    }
    return list;
  }
}

class FontVariant extends StatelessWidget {
  const FontVariant({
    Key? key,
    required this.fontType,
  }) : super(key: key);

  final AppFontType fontType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Consumer(builder: (context, ThemeManager themeNotifier, child) {
        bool isCurrentFont = fontType == themeNotifier.theme.font;
        return GestureDetector(
          onTap: isCurrentFont
              ? null
              : () {
                  themeNotifier.setThemeFont(fontType);
                },
          child: _buildFontWidget(fontType, context),
        );
      }),
    );
  }
}

Widget _buildFontWidget(AppFontType fontType, BuildContext context) {
  late Widget fontWidget;
  switch (fontType) {
    case AppFontType.pixel:
      fontWidget = Text(
        AppLocalizations.of(context)!.pixel,
        style: TextStyle(
          fontFamily: fontFamily(fontType),
          fontSize: AppTheme.defaultFontSize(fontType),
        ),
      );
      break;
    case AppFontType.classic:
      fontWidget = Text(
        AppLocalizations.of(context)!.classic,
        style: TextStyle(
          fontFamily: fontFamily(fontType),
          fontSize: AppTheme.defaultFontSize(fontType),
        ),
      );
      break;
  }
  return fontWidget;
}
