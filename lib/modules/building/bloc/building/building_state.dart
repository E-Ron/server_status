part of 'building_bloc.dart';

abstract class BuildingState extends Equatable {
  const BuildingState();

  @override
  List<Object?> get props => [];
}

class BuildingInitial extends BuildingState {}

class BuildingSuccess extends BuildingState {
  const BuildingSuccess({
    required this.buildingList,
  });

  final List<Building> buildingList;

  @override
  List<Object?> get props => [buildingList];
}

class BuildingError extends BuildingState {}
