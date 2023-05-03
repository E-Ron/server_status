import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:server_status/models/player.dart';
import '../bloc/server_status_bloc.dart';
import 'player_list_item.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({
    super.key,
    required this.players,
  });

  final List<Player> players;

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.playersListEmpty),
      );
    } else {
      return RefreshIndicator(
        strokeWidth: 2,
        onRefresh: () async {
          context.read<ServerStatusBloc>().add(ServerStatusFetched());
        },
        child: ListView.separated(
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
        ),
      );
    }
  }
}
