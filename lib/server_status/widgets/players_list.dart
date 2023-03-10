import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_status/server_status/bloc/server_status_bloc.dart';
import 'package:minecraft_server_status/server_status/widgets/loading_animation.dart';
import 'package:minecraft_server_status/server_status/widgets/player_list_item.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServerStatusBloc, ServerStatusState>(
        builder: (context, state) {
      switch (state.fetchStatus) {
        case ServerFetchStatus.loading:
          return const LoadingAnimation();
        case ServerFetchStatus.failure:
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                'Не удалось получить список игроков.',
                textAlign: TextAlign.center,
                style: TextStyle(height: 2),
              ),
            ),
          );
        case ServerFetchStatus.success:
          final players = state.serverStatus.players;
          if (players.isEmpty) {
            return const Center(
              child: Text('Никого нет на сервере...'),
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
    });
  }
}
