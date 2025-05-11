import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/common/utils/constants.dart';
import 'package:doctorapp/models/specialist.dart';

class SpecialistRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Specialist>> getSpecialists() {
    return firestore.collection(specialistsCollection).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        return Specialist.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<Specialist?> getSpecialistById(String id) async {
    final doc = await firestore.collection(specialistsCollection).doc(id).get();
    if (doc.exists) {
      return Specialist.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    } else {
      return null;
    }
  }
}
