import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:minecraft_server_status/widgets/loading_animation.dart';
import '../bloc/server_status_bloc.dart';
import '../widgets/players_list.dart';

class ServerStatusScreen extends StatelessWidget {
  const ServerStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServerStatusBloc, ServerStatusState>(
        builder: (context, state) {
      switch (state.fetchStatus) {
        case ServerFetchStatus.loading:
          return const LoadingAnimation();
        case ServerFetchStatus.failure:
          return Center(
            child: Text(
              AppLocalizations.of(context)!.playersListError,
              textAlign: TextAlign.center,
              style: const TextStyle(height: 2),
            ),
          );
        case ServerFetchStatus.success:
          return PlayersList(players: state.serverStatus.players);
      }
    });
  }
}
