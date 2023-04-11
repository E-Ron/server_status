import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/server_status_bloc.dart';
import '../models/server_status.dart';
import 'fetch_wrapper.dart';

class ServerStatusAction extends StatelessWidget {
  const ServerStatusAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServerStatusBloc, ServerStatusState>(
      builder: (context, state) {
        switch (state.fetchStatus) {
          case ServerFetchStatus.loading:
            return Row(
              children: [
                Text(AppLocalizations.of(context)!.loading),
                SizedBox(
                  width: 43,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText(
                        '...',
                        speed: const Duration(seconds: 1),
                      ),
                    ],
                  ),
                ),
              ],
            );
          case ServerFetchStatus.success:
            switch (state.serverStatus.onlineStatus) {
              case OnlineStatus.online:
                return FetchWrapper(
                  text: AppLocalizations.of(context)!.onlineCounter(
                    state.serverStatus.playersOnline,
                  ),
                  color: Colors.greenAccent,
                );
              case OnlineStatus.offline:
                return FetchWrapper(
                  text: AppLocalizations.of(context)!.offline,
                  color: Colors.redAccent,
                );
              case OnlineStatus.undefine:
                return FetchWrapper(
                  text: AppLocalizations.of(context)!.error,
                  color: Colors.grey,
                );
            }
          case ServerFetchStatus.failure:
            return FetchWrapper(
              text: AppLocalizations.of(context)!.error,
              color: Colors.redAccent,
            );
          //TODO add different error for server disabled and user havent internet
        }
      },
    );
  }
}
