import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/server_status.dart';

class ServerStatusRepository {
  ServerStatusRepository({required http.Client client})
      : service = ServerStatusService(client: client);

  final ServerStatusService service;

  Future<ServerStatus> retrieveServerStatus() {
    return service.retrieveServerStatus();
  }
}

class ServerStatusService {
  ServerStatusService({required this.client});

  final http.Client client;

  static const _statusBaseUrl = 'api.mcstatus.io';
  static const _statusMethodPath = 'v2/status/java/';
  static const _minecraftServerIp =
      String.fromEnvironment('MINECRAFT_SERVER_IP');

  static Uri get serviceUri {
    return Uri.https(_statusBaseUrl, '$_statusMethodPath$_minecraftServerIp');
  }

  Future<ServerStatus> retrieveServerStatus() async {
    final response = await client.get(serviceUri);
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      return ServerStatus.fromJson(body);
    }

    return const ServerStatus.initial();
  }
}
