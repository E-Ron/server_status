import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/server_status_action.dart';

class ServerStatusAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ServerStatusAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.serverStatus,
        style: const TextStyle(fontSize: 14),
      ),
      actions: const [
        ServerStatusAction(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
