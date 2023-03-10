import 'package:minecraft_server_status/server_status/models/player.dart';

enum OnlineStatus { online, offline, undefine }

class ServerStatus {
  const ServerStatus({
    required this.onlineStatus,
    required this.catchTime,
    required this.players,
    required this.playersOnline,
  });

  final OnlineStatus onlineStatus;
  final CatchTime catchTime;
  final List<Player> players;
  final int playersOnline;

  const ServerStatus.initial()
      : this(
          onlineStatus: OnlineStatus.undefine,
          catchTime: const CatchTime.initial(),
          players: const [],
          playersOnline: 0,
        );

  factory ServerStatus.fromJson(Map<String, dynamic> json) {
    OnlineStatus onlineStatus =
        json['online'] == true ? OnlineStatus.online : OnlineStatus.offline;

    CatchTime catchTime = CatchTime(
      retrievedAt: json['retrieved_at'],
      expiresAt: json['expires_at'],
    );

    List<Player> players = [];
    for (Map<String, dynamic> player in json['players']['list']) {
      players.add(player['name_clean'] as Player);
    }
    int playersOnline = json['players']['online'];

    return ServerStatus(
      onlineStatus: onlineStatus,
      catchTime: catchTime,
      players: players,
      playersOnline: playersOnline,
    );
  }
}

class CatchTime {
  const CatchTime({
    required this.retrievedAt,
    required this.expiresAt,
  });

  final int retrievedAt;
  final int expiresAt;

  const CatchTime.initial()
      : this(
          expiresAt: 0,
          retrievedAt: 0,
        );
}
