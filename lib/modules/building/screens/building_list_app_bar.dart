import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/filter_button.dart';

class BuildingListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BuildingListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.buildingList,
        style: const TextStyle(fontSize: 16),
      ),
      actions: const [
        FilterButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
