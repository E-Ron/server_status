import 'package:flutter_test/flutter_test.dart';

import 'package:minecraft_server_status/modules/server_status/models/server_status.dart';

void main() {
  group('Server Status', () {
    group('fromJson', () {
      test('returns correct Server Status', () {
        expect(
          ServerStatus.fromJson(
            const <String, dynamic>{
              "online": true,
              "retrieved_at": 1678001174425,
              "expires_at": 1678001234425,
              "players": {
                "online": 1,
                "list": [
                  {"name_clean": "Player"}
                ]
              }
            },
          ),
          isA<ServerStatus>()
              .having(
                (w) => w.onlineStatus,
                'online status',
                OnlineStatus.online,
              )
              .having(
                (w) => w.catchTime.retrievedAt,
                'catch time retrieved',
                1678001174425,
              )
              .having(
                (w) => w.catchTime.expiresAt,
                'catch time expires',
                1678001234425,
              )
              .having(
            (w) => w.players,
            'players list',
            ["Player"],
          ).having(
            (w) => w.playersOnline,
            'players online',
            1,
          ),
        );
      });
    });
  });
}
