import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/building.dart';
import '../models/building_filter.dart';
import '../models/owner.dart';
import '../models/selected_owner.dart';

class BuildingRepository {
  BuildingService service = BuildingService();

  Future<List<Building>> retrieveBuildingData() {
    return service.retrieveBuildingData();
  }

  Future<BuildingFilter> retrieveFilterData() {
    return service.retrieveFilterData();
  }

  Future<List<Building>> retrieveFilteredBuildingData(BuildingFilter filter) {
    return service.retrieveFilteredBuildingData(filter);
  }
}

class BuildingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Building>> retrieveBuildingData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('buildings').get();
    return snapshot.docs
        .map((docSnapshot) => Building.fromJson(docSnapshot.data()))
        .toList();
  }

  Future<BuildingFilter> retrieveFilterData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('owners').get();
    final List<Owner> owners = snapshot.docs
        .map((docSnapshot) => docSnapshot.data()['name'] as Owner)
        .toList();
    return BuildingFilter.initial().copyWith(owners: owners);
  }

  Future<List<Building>> retrieveFilteredBuildingData(
      BuildingFilter filter) async {
    final CollectionReference collection = _db.collection('buildings');
    late final Query filteredCollection;
    if (filter.selectedOwner.type == SelectedType.any) {
      filteredCollection = collection;
    } else {
      filteredCollection =
          collection.where('owners', arrayContains: filter.selectedOwner.owner);
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await filteredCollection.get() as QuerySnapshot<Map<String, dynamic>>;

    return snapshot.docs.map((docSnapshot) {
      return Building.fromJson(docSnapshot.data());
    }).toList();
  }
}
