import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/building.dart';
import '../models/owner.dart';

class BuildingListItem extends StatelessWidget {
  const BuildingListItem({
    super.key,
    required this.building,
  });

  final Building building;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      color: Colors.black26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBuildingName(),
          _buildCoordinates(),
          _buildOwners(context),
        ],
      ),
    );
  }

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    shadows: [
      Shadow(
        offset: Offset(2, 2),
        color: Color.fromRGBO(62, 62, 62, 1),
      ),
    ],
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 10,
    height: 1.4,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        color: Color.fromRGBO(62, 62, 62, 1),
      ),
    ],
  );

  Color _getColorBasedOnDimension(Dimension dimension) {
    switch (dimension) {
      case Dimension.overworld:
        return Colors.white;
      case Dimension.theNether:
        return Colors.redAccent;
      case Dimension.theEnd:
        return Colors.amberAccent;
      case Dimension.unknown:
        return Colors.white;
    }
  }

  Widget _buildBuildingName() {
    return Text(
      building.name,
      style: titleTextStyle,
    );
  }

  Widget _buildCoordinates() {
    String formatCoordinates(Coordinates coordinates) {
      String result = '';
      if (coordinates.x != null) {
        result += 'x:${coordinates.x},';
      }
      if (coordinates.y != null) {
        result += 'y:${coordinates.y},';
      }
      if (coordinates.z != null) {
        result += 'z:${coordinates.z},';
      }
      if (result != '') {
        result = result.substring(0, result.length - 1);
      }
      return result;
    }

    String formattedCoordinates = formatCoordinates(building.coordinates);
    Color coordinatesColor =
        _getColorBasedOnDimension(building.coordinates.dimension);

    return Text(
      formattedCoordinates,
      style: subtitleTextStyle.copyWith(color: coordinatesColor),
    );
  }

  Widget _buildOwners(BuildContext context) {
    String formatOwners(List<Owner> owners) {
      if (owners.isNotEmpty) {
        return owners.reduce((value, element) => '$value $element');
      } else {
        return AppLocalizations.of(context)!.noOwner;
      }
    }

    String formattedOwners = formatOwners(building.owners);

    return Text(
      formattedOwners,
      style: subtitleTextStyle.copyWith(color: Colors.white),
    );
  }
}
