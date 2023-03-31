import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../models/server_status.dart';
import 'sever_status_repository_impl.dart';

part 'server_status_event.dart';
part 'server_status_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ServerStatusBloc extends Bloc<ServerStatusEvent, ServerStatusState> {
  ServerStatusBloc(this.serverStatusRepository)
      : super(const ServerStatusState()) {
    on<ServerStatusFetched>(
      _onServerStatusFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  ServerStatusRepository serverStatusRepository;

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

  Future<ServerStatus> _fetchServerStatus() async {
    return serverStatusRepository.retrieveServerStatus();
  }
}
