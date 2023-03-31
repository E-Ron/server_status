import 'owner.dart';

enum Dimension { overworld, theNether, theEnd, unknown }

class Building {
  Building({
    required this.coordinates,
    required this.name,
    required this.owners,
  });

  final Coordinates coordinates;
  final String name;
  final List<Owner> owners;

  factory Building.fromJson(Map<String, dynamic> json) {
    late Coordinates coordinates;
    if (json['coordinates'] != null) {
      coordinates = Coordinates.fromJson(
        json['coordinates'],
      );
    } else {
      coordinates = Coordinates.empty();
    }

    String name = json['name'] ?? '';
    List<String> owners = [];
    if (json['owners'] != null) {
      owners = List<String>.from(json['owners']);
    }
    return Building(
      coordinates: coordinates,
      name: name,
      owners: owners,
    );
  }
}

class Coordinates {
  Coordinates({
    required this.x,
    required this.y,
    required this.z,
    required this.dimension,
  });

  Coordinates.empty()
      : this(
          x: null,
          y: null,
          z: null,
          dimension: Dimension.unknown,
        );

  final int? x;
  final int? y;
  final int? z;
  final Dimension dimension;

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    int? x = json['x'];
    int? y = json['y'];
    int? z = json['z'];
    Dimension dimension = _dimensionFromJson(json['dimension']);
    return Coordinates(
      x: x,
      y: y,
      z: z,
      dimension: dimension,
    );
  }
}

Dimension _dimensionFromJson(String? jsonDimension) {
  switch (jsonDimension) {
    case 'overworld':
      return Dimension.overworld;
    case 'the_nether':
      return Dimension.theNether;
    case 'the_end':
      return Dimension.theEnd;
    default:
      return Dimension.unknown;
  }
}
