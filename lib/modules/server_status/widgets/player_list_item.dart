import 'package:flutter/material.dart';

import 'package:server_status/models/player.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/default_skin.png',
              width: 32,
              height: 32,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            player,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  color: Color.fromRGBO(62, 62, 62, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
