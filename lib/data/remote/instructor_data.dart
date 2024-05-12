import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:license/res/types.dart';

class InstructorData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Instructor>> getInstructors() async {
    try {
      final snapshot = await _firestore.collection('instructors').get();
      return snapshot.docs
          .map((doc) => Instructor(
                id: doc.id,
                name: doc['name'],
                email: doc['email'],
                image: doc['image'],
                desc: doc['desc'],
                availableTimes: doc["availableTimes"],
              ))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Instructor> getInstructor(String id) async {
    try {
      final snapshot = await _firestore.collection('instructors').doc(id).get();
      return Instructor(
        id: snapshot.id,
        name: snapshot['name'],
        email: snapshot['email'],
        image: snapshot['image'],
        desc: snapshot['desc'],
        availableTimes: snapshot["availableTimes"],
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
