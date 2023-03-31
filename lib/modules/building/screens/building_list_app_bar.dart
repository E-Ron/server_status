import 'package:flutter/material.dart';

import '../widgets/filter_button.dart';

class BuildingListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BuildingListAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Список построек',
        style: TextStyle(fontSize: 16),
      ),
      actions: const [
        FilterButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
