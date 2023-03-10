import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_status/server_status/bloc/server_status_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:minecraft_server_status/server_status/widgets/players_list.dart';
import 'package:minecraft_server_status/server_status/widgets/status_app_bar.dart';

class ServerStatusPage extends StatelessWidget {
  const ServerStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServerStatusBloc(httpClient: http.Client())
        ..add(ServerStatusFetched()),
      child: BlocBuilder<ServerStatusBloc, ServerStatusState>(
          builder: (context, state) {
        return const Scaffold(
          appBar: StatusAppBar(),
          body: PlayersList(),
        );
      }),
    );
  }
}
