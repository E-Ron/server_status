import 'owner.dart';

enum SelectedType {
  any,
  singeOwner,
}

class SelectedOwner {
  SelectedOwner({
    this.owner,
    required this.type,
  });

  final Owner? owner;
  final SelectedType type;
}
