part of 'filter_bloc.dart';

@immutable
abstract class FilterState extends Equatable {
  const FilterState({required this.buildingFilter});

  final BuildingFilter buildingFilter;

  @override
  List<Object?> get props => [buildingFilter];
}

class FilterInitial extends FilterState {
  const FilterInitial({required super.buildingFilter});
}

class FilterSuccess extends FilterState {
  const FilterSuccess({required super.buildingFilter});
}

class FilterError extends FilterState {
  const FilterError({required super.buildingFilter});
}
