import 'owner.dart';

enum SelectedType {
  any,
  singeOwner,
}

class BuildingFilter {
  const BuildingFilter({
    required this.owners,
    required this.selectedOwner,
  });
  final List<Owner> owners;
  final SelectedOwner selectedOwner;

  BuildingFilter.initial()
      : this(
          owners: [],
          selectedOwner: SelectedOwner(
            type: SelectedType.any,
          ),
        );

  BuildingFilter copyWith({
    List<Owner>? owners,
    SelectedOwner? selectedOwner,
  }) {
    return BuildingFilter(
      owners: owners ?? this.owners,
      selectedOwner: selectedOwner ?? this.selectedOwner,
    );
  }
}

class SelectedOwner {
  SelectedOwner({
    this.owner,
    required this.type,
  });

  final Owner? owner;
  final SelectedType type;
}
