import 'package:flutter_test/flutter_test.dart';
import 'package:minecraft_server_status/server_status/models/server_status.dart';

void main() {
  group('Server Status', () {
    group('fromJson', () {
      test('returns correct Server Status', () {
        const catchTime =
            CatchTime(retrievedAt: 1678001174425, expiresAt: 1678001234425);

        expect(
          ServerStatus.fromJson(
            const <String, dynamic>{
              "online": true,
              "host": "5.166.213.130",
              "port": 25565,
              "eula_blocked": false,
              "retrieved_at": 1678001174425,
              "expires_at": 1678001234425,
              "version": {
                "name_raw": "Paper 1.19.2",
                "name_clean": "Paper 1.19.2",
                "name_html":
                    "<span><span style=\"color: #ffffff;\">Paper 1.19.2</span></span>",
                "protocol": 760
              },
              "players": {
                "online": 1,
                "max": 50,
                "list": [
                  {
                    "uuid": "46681254-6bd1-328f-b8ad-f685c20bab5e",
                    "name_raw": "MIhai_Mocanu",
                    "name_clean": "MIhai_Mocanu",
                    "name_html":
                        "<span><span style=\"color: #ffffff;\">MIhai_Mocanu</span></span>"
                  }
                ]
              },
              "motd": {
                "raw": "ANIpatiServer",
                "clean": "ANIpatiServer",
                "html":
                    "<span><span style=\"color: #ffffff;\">ANIpatiServer</span></span>"
              },
              "icon":
                  "data:image/png;base64,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",
              "mods": []
            },
          ),
          isA<ServerStatus>()
              .having(
                  (w) => w.onlineStatus, 'online status', OnlineStatus.online)
              .having((w) => w.catchTime.retrievedAt, 'catch time retrieved',
                  catchTime.retrievedAt)
              .having((w) => w.catchTime.expiresAt, 'catch time expires',
                  catchTime.expiresAt)
              .having((w) => w.catchTime.expiresAt, 'catch time expires',
                  catchTime.expiresAt)
              .having((w) => w.players, 'players list', [
            "MIhai_Mocanu"
          ]).having((w) => w.playersOnline, 'players online', 1),
        );
      });
    });
  });
}
