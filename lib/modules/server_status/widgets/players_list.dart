import 'package:flutter/material.dart';

import 'package:minecraft_server_status/models/player.dart';
import 'player_list_item.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({
    super.key,
    required this.players,
  });

  final List<Player> players;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 5,
        color: Colors.black38,
      ),
      itemBuilder: (context, index) {
        return PlayerListItem(
          player: players[index],
        );
      },
      itemCount: players.length,
    );
  }
}
