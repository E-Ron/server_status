import 'package:flutter/material.dart';

import '../models/building.dart';
import 'building_list_item.dart';

class BuildingList extends StatelessWidget {
  const BuildingList({
    super.key,
    required this.buildings,
  });

  final List<Building> buildings;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 5,
        color: Colors.black38,
      ),
      itemBuilder: (context, index) {
        return BuildingListItem(
          building: buildings[index],
        );
      },
      itemCount: buildings.length,
    );
  }
}
