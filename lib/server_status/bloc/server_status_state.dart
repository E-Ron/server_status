part of 'server_status_bloc.dart';

enum ServerFetchStatus { loading, success, failure }

class ServerStatusState {
  const ServerStatusState({
    this.fetchStatus = ServerFetchStatus.loading,
    this.serverStatus = const ServerStatus.initial(),
  });

  final ServerFetchStatus fetchStatus;
  final ServerStatus serverStatus;

  ServerStatusState copyWith({
    ServerFetchStatus? fetchStatus,
    ServerStatus? serverStatus,
  }) {
    return ServerStatusState(
      fetchStatus: fetchStatus ?? this.fetchStatus,
      serverStatus: serverStatus ?? this.serverStatus,
    );
  }
}
