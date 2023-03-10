import 'package:flutter/material.dart';
import 'package:minecraft_server_status/server_status/view/server_status_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'PressStart2P',
      ),
      home: const ServerStatusPage(),
    );
  }
}
