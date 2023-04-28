import 'owner.dart';
import 'selected_owner.dart';

class BuildingFilter {
  const BuildingFilter({
    required this.owners,
    required this.selectedOwner,
  });

  BuildingFilter.initial()
      : this(
          owners: [],
          selectedOwner: SelectedOwner(
            type: SelectedType.any,
          ),
        );

  final List<Owner> owners;
  final SelectedOwner selectedOwner;

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
