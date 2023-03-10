import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_status/server_status/bloc/server_status_bloc.dart';
import 'package:minecraft_server_status/server_status/models/server_status.dart';
import 'package:minecraft_server_status/server_status/widgets/fetch_wrapper.dart';

class ServerStatusAction extends StatelessWidget {
  const ServerStatusAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServerStatusBloc, ServerStatusState>(
      builder: (context, state) {
        switch (state.fetchStatus) {
          case ServerFetchStatus.loading:
            return Row(
              children: [
                const Text('Загрузка'),
                SizedBox(
                  width: 43,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText('...',
                          speed: const Duration(seconds: 1)),
                    ],
                  ),
                ),
              ],
            );
          case ServerFetchStatus.success:
            switch (state.serverStatus.onlineStatus) {
              case OnlineStatus.online:
                return FetchWrapper(
                  text: '${state.serverStatus.playersOnline} в сети',
                  color: Colors.lightGreenAccent,
                );
              case OnlineStatus.offline:
                return const FetchWrapper(
                  text: 'Не в сети',
                  color: Colors.redAccent,
                );
              case OnlineStatus.undefine:
                return const FetchWrapper(
                  text: 'Сервер недоступен',
                  color: Colors.grey,
                );
            }
          case ServerFetchStatus.failure:
            return const FetchWrapper(
              text: 'Ошибка',
              color: Colors.redAccent,
            );
          //TODO add different error for server disabled and user havent internet
        }
      },
    );
  }
}
