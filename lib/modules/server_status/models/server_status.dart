import 'package:server_status/models/player.dart';

import 'catch_time.dart';

enum OnlineStatus { online, offline, undefine }

class ServerStatus {
  const ServerStatus({
    required this.onlineStatus,
    required this.catchTime,
    required this.players,
    required this.playersOnline,
  });

  const ServerStatus.initial()
      : this(
          onlineStatus: OnlineStatus.undefine,
          catchTime: const CatchTime.initial(),
          players: const [],
          playersOnline: 0,
        );

  factory ServerStatus.fromJson(Map<String, dynamic> json) {
    final OnlineStatus onlineStatus =
        json['online'] == true ? OnlineStatus.online : OnlineStatus.offline;

    final CatchTime catchTime = CatchTime(
      retrievedAt: json['retrieved_at'],
      expiresAt: json['expires_at'],
    );

    final List<Player> players = [];
    for (final Map<String, dynamic> player in json['players']['list']) {
      players.add(player['name_clean'] as Player);
    }
    final int playersOnline = json['players']['online'];

    return ServerStatus(
      onlineStatus: onlineStatus,
      catchTime: catchTime,
      players: players,
      playersOnline: playersOnline,
    );
  }

  final OnlineStatus onlineStatus;
  final CatchTime catchTime;
  final List<Player> players;
  final int playersOnline;
}
