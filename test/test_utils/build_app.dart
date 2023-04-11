import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:minecraft_server_status/app.dart';

MaterialApp buildLocalizedMaterialApp(
    {required GlobalKey<NavigatorState> navigatorKey, required Widget home}) {
  return MaterialApp(
    navigatorKey: navigatorKey,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: App.supportedLocales,
    home: home,
  );
}
