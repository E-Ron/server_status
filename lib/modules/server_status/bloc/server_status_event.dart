part of 'server_status_bloc.dart';

abstract class ServerStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerStatusFetched extends ServerStatusEvent {}
