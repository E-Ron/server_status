import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minecraft_server_status/models/player.dart';
import 'package:minecraft_server_status/modules/server_status/widgets/player_list_item.dart';

void main() {
  const Player mockPlayer = 'LimitedAsm';

  group('Player list item', () {
    Widget widget = const MaterialApp(
      home: PlayerListItem(player: mockPlayer),
    );
    testWidgets('has name', (tester) async {
      await tester.pumpWidget(widget);
      final nameFinder = find.text('LimitedAsm');
      expect(nameFinder, findsOneWidget);
    });
    testWidgets('has avatar', (tester) async {
      await tester.pumpWidget(widget);
      final avatarFinder =
          find.image(const AssetImage('assets/images/default_skin.png'));
      expect(avatarFinder, findsOneWidget);
    });
  });
}
