import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:minecraft_server_status/modules/server_status/models/server_status.dart';
import 'package:minecraft_server_status/modules/server_status/repository/sever_status_repository.dart';

@GenerateMocks([http.Client])
import 'server_status_repository_test.mocks.dart';

void main() {
  group('Server status repository', () {
    const serverResponse = '{'
        '"online": true,'
        '"retrieved_at": 1678001174425,'
        '"expires_at": 1678001234425,'
        '"players": {'
        '"online": 1,'
        '"list": [{"name_clean": "Player"}]'
        '}'
        '}';

    test('Online server status if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(ServerStatusService.serviceUri))
          .thenAnswer((_) async => http.Response(serverResponse, 200));

      final repository = ServerStatusRepository(client: client);

      final ServerStatus serverStatus = await repository.retrieveServerStatus();

      expect(serverStatus.onlineStatus, equals(OnlineStatus.online));
    });

    test('Undefine server status if the http call completes with an error',
        () async {
      final client = MockClient();

      when(client.get(ServerStatusService.serviceUri))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final repository = ServerStatusRepository(client: client);

      final ServerStatus serverStatus = await repository.retrieveServerStatus();

      expect(serverStatus.onlineStatus, equals(OnlineStatus.undefine));
    });
  });
}
