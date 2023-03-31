import 'package:flutter/material.dart';

import '../widgets/server_status_action.dart';

class StatusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatusAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Статус сервера',
        style: TextStyle(fontSize: 14),
      ),
      actions: const [
        ServerStatusAction(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
