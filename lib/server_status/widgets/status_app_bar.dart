import 'package:flutter/material.dart';
import 'package:minecraft_server_status/server_status/widgets/server_status_action.dart';

class StatusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatusAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.lightBlueAccent.shade100,
      title: const Text(
        'Статус сервера',
        style: TextStyle(fontSize: 16),
      ),
      actions: const [ServerStatusAction()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
