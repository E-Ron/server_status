import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/server_status.dart';

abstract class ServerStatusRepository {
  Future<ServerStatus> retrieveServerStatus();
}

class ServerStatusRepositoryImpl implements ServerStatusRepository {
  ServerStatusService service = ServerStatusService();

  @override
  Future<ServerStatus> retrieveServerStatus() {
    return service.retrieveServerStatus();
  }
}

class ServerStatusService {
  static const _statusBaseUrl = 'api.mcstatus.io';
  static const _statusMethodPath = 'v2/status/java/';
  static const _minecraftServerIp =
      String.fromEnvironment('MINECRAFT_SERVER_IP');

  Future<ServerStatus> retrieveServerStatus() async {
    print('object');
    final response = await http.get(
      Uri.https(_statusBaseUrl, '$_statusMethodPath$_minecraftServerIp'),
    );
    if (response.statusCode == 200) {
      print('object1');

      final body = json.decode(response.body) as Map<String, dynamic>;
      return ServerStatus.fromJson(body);
    }

    return const ServerStatus.initial();
  }
}
