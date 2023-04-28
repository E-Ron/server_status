import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minecraft_server_status/models/player.dart';
import 'package:minecraft_server_status/modules/server_status/widgets/players_list.dart';
import '../test_utils/build_app.dart';

void main() {
  group('Player list', () {
    const Player mockPlayer1 = 'Player1';
    const Player mockPlayer2 = 'Player2';
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

    testWidgets('is empty', (tester) async {
      const List<Player> mockPlayerList = [];

      final Widget app = buildLocalizedMaterialApp(
        home: const PlayersList(players: mockPlayerList),
        navigatorKey: navigatorKey,
      );

      await tester.pumpWidget(app);

      final nameFinder = find.text(
        AppLocalizations.of(navigatorKey.currentContext!)!.playersListEmpty,
      );
      expect(nameFinder, findsOneWidget);
    });

    testWidgets('has player', (tester) async {
      const List<Player> mockPlayerList = [mockPlayer1];

      final Widget app = buildLocalizedMaterialApp(
        home: const PlayersList(players: mockPlayerList),
        navigatorKey: navigatorKey,
      );

      await tester.pumpWidget(app);

      expect(find.text(mockPlayer1), findsOneWidget);
    });

    testWidgets('has two players', (tester) async {
      const List<Player> mockPlayerList = [mockPlayer1, mockPlayer2];

      final Widget app = buildLocalizedMaterialApp(
        home: const PlayersList(players: mockPlayerList),
        navigatorKey: navigatorKey,
      );

      await tester.pumpWidget(app);

      expect(find.text(mockPlayer1), findsOneWidget);
      expect(find.text(mockPlayer2), findsOneWidget);
    });
  });
}
