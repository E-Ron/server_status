part of 'building_bloc.dart';

abstract class BuildingEvent {
  const BuildingEvent();
}

class BuildingInitialFetched extends BuildingEvent {
  const BuildingInitialFetched();
}

class BuildingFilteredFetched extends BuildingEvent {
  const BuildingFilteredFetched({required this.filter});
  final BuildingFilter filter;
}

class BuildingAdded extends BuildingEvent {
  const BuildingAdded();
}
