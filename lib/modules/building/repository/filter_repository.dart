import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/owner.dart';

class FilterRepository {
  FilterService service = FilterService();

  Future<List<Owner>> retrieveFilterData() {
    return service.retrieveFilterData();
  }
}

class FilterService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<Owner>> retrieveFilterData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('owners').get();

    final List<Owner> owners = snapshot.docs.map((docSnapshot) {
      return docSnapshot.data()['name'] as Owner;
    }).toList();

    return owners;
  }
}
