import 'package:flutter/material.dart';

import 'font_settings.dart';
import 'theme_settings.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: ThemeSettings(),
          ),
          FontSettings(),
        ],
      ),
    );
  }
}
