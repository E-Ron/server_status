import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/building.dart';
import '../../models/building_filter.dart';
import 'building_repository_impl.dart';

part 'building_event.dart';
part 'building_state.dart';

class BuildingBloc extends Bloc<BuildingEvent, BuildingState> {
  BuildingBloc(this._buildingRepository) : super(BuildingInitial()) {
    on<BuildingInitialFetched>(_initialFetchBuilding);
    on<BuildingFilteredFetched>(_filteredFetchBuilding);
  }

  final BuildingRepository _buildingRepository;

  _initialFetchBuilding(
      BuildingInitialFetched event, Emitter<BuildingState> emit) async {
    await _buildingRepository.retrieveBuildingData().then((buildingList) {
      emit(BuildingSuccess(
        buildingList: buildingList,
      ));
    });
  }

  _filteredFetchBuilding(
      BuildingFilteredFetched event, Emitter<BuildingState> emit) async {
    await _buildingRepository
        .retrieveFilteredBuildingData(event.filter)
        .then((buildingList) {
      emit(BuildingSuccess(
        buildingList: buildingList,
      ));
    });
  }
}
