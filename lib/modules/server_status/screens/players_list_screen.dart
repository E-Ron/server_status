import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minecraft_server_status/widgets/loading_animation.dart';
import '../bloc/server_status_bloc.dart';
import '../widgets/players_list.dart';

class PlayersListScreen extends StatelessWidget {
  const PlayersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServerStatusBloc, ServerStatusState>(
        builder: (context, state) {
      switch (state.fetchStatus) {
        case ServerFetchStatus.loading:
          return const LoadingAnimation();
        case ServerFetchStatus.failure:
          return const Center(
            child: Text(
              'Не удалось получить\nсписок игроков.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 2),
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
              child: PlayersList(players: players),
            );
          }
      }
    });
  }
}
