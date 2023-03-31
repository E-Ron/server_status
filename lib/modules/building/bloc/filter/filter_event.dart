part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent {
  const FilterEvent();
}

class OwnersFetched extends FilterEvent {
  const OwnersFetched();
}

class SelectedOwnerChanged extends FilterEvent {
  const SelectedOwnerChanged({required this.selectedOwner});
  final SelectedOwner selectedOwner;
}
