import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:minecraft_server_status/server_status/models/server_status.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'server_status_event.dart';
part 'server_status_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ServerStatusBloc extends Bloc<ServerStatusEvent, ServerStatusState> {
  ServerStatusBloc({required this.httpClient})
      : super(const ServerStatusState()) {
    on<ServerStatusFetched>(
      _onServerStatusFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onServerStatusFetched(
      ServerStatusFetched event, Emitter<ServerStatusState> emit) async {
    try {
      emit(state.copyWith(fetchStatus: ServerFetchStatus.loading));
      final serverState = await _fetchServerStatus();
      emit(
        state.copyWith(
          fetchStatus: ServerFetchStatus.success,
          serverStatus: serverState,
        ),
      );
    } catch (_) {
      emit(state.copyWith(fetchStatus: ServerFetchStatus.failure));
    }
  }

  static const _statusBaseUrl = 'api.mcstatus.io';
  static const _statusMethodPath = 'v2/status/java/';
  static const _minecraftServerIp =
      String.fromEnvironment('MINECRAFT_SERVER_IP');
  Future<ServerStatus> _fetchServerStatus() async {
    final response = await http.get(
      Uri.https(_statusBaseUrl, '$_statusMethodPath$_minecraftServerIp'),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      return ServerStatus.fromJson(body);
    }

    throw Exception('error fetching server status');
  }
}
