import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minecraft_server_status/modules/building/models/building.dart';
import 'package:minecraft_server_status/modules/building/models/building_filter.dart';
import 'package:minecraft_server_status/modules/building/models/owner.dart';

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
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('buildings').get();
    return snapshot.docs
        .map((docSnapshot) => Building.fromJson(docSnapshot.data()))
        .toList();
  }

  Future<BuildingFilter> retrieveFilterData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('owners').get();
    List<Owner> owners = snapshot.docs
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
          collection.where("owners", arrayContains: filter.selectedOwner.owner);
    }

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await filteredCollection.get() as QuerySnapshot<Map<String, dynamic>>;

    return snapshot.docs.map((docSnapshot) {
      return Building.fromJson(docSnapshot.data());
    }).toList();
  }
}
