import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:license/res/types.dart';

class InstructorData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Instructor>> getInstructors() async {
    try {
      final snapshot = await _firestore.collection('instructors').get();
      return snapshot.docs.map((doc) {
        final instructor = Instructor(
          id: doc.id,
          name: doc['name'],
          email: doc['email'],
          image: doc['image'],
          desc: doc['desc'],
          availableTimes: _convertAvailableTimes(doc["availableTimes"]),
        );

        return instructor;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Map<int, dynamic> _convertAvailableTimes(dynamic availableTimes) {
    if (availableTimes == null) {
      return {};
    }

    Map<int, dynamic> newAvailableTimes = {};
    availableTimes.forEach((key, value) {
      newAvailableTimes[int.parse(key)] = value;
    });
    return newAvailableTimes;
  }

  Future<void> removeTimeFromInstructorFromDay(
      String instructorEmail, int day, String time) async {
    try {
      final snapshot = await _firestore
          .collection('instructors')
          .where('email', isEqualTo: instructorEmail)
          .get();

      final Map<String, dynamic> availableTimesMap =
          snapshot.docs[0]["availableTimes"];

      final Map<int, dynamic> convertedAvailableTimes = availableTimesMap
          .map((key, value) => MapEntry(int.parse(key), value));

      convertedAvailableTimes[day].remove(time);

      final Map<String, dynamic> availableTimesAsString =
          convertedAvailableTimes.map(
        (key, value) => MapEntry(key.toString(), value),
      );

      await _firestore
          .collection('instructors')
          .doc(snapshot.docs[0].id)
          .update({'availableTimes': availableTimesAsString});
    } catch (e) {
      rethrow;
    }
  }

  Future<Instructor> getInstructorByEmail(String email) async {
    try {
      final snapshot = await _firestore
          .collection('instructors')
          .where('email', isEqualTo: email)
          .get();

      final Map<String, dynamic> availableTimesMap =
          snapshot.docs[0]["availableTimes"];

      final Map<int, dynamic> convertedAvailableTimes = availableTimesMap
          .map((key, value) => MapEntry(int.parse(key), value));

      return Instructor(
        id: snapshot.docs[0].id,
        name: snapshot.docs[0]['name'],
        email: snapshot.docs[0]['email'],
        image: snapshot.docs[0]['image'],
        desc: snapshot.docs[0]['desc'],
        availableTimes: convertedAvailableTimes,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Instructor> getInstructor(String id) async {
    try {
      final snapshot = await _firestore.collection('instructors').doc(id).get();

      final availableTimesMap =
          _convertAvailableTimes(snapshot['availableTimes']);

      return Instructor(
        id: snapshot.id,
        name: snapshot['name'],
        email: snapshot['email'],
        image: snapshot['image'],
        desc: snapshot['desc'],
        availableTimes: availableTimesMap,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateInstructor(Instructor instructor) async {
    try {
      final Map<String, dynamic> availableTimesAsString =
          instructor.availableTimes.map(
        (key, value) => MapEntry(key.toString(), value),
      );

      await _firestore.collection('instructors').doc(instructor.id).update({
        'name': instructor.name,
        'email': instructor.email,
        'image': instructor.image,
        'desc': instructor.desc,
        'availableTimes': availableTimesAsString,
      });
    } catch (e) {
      rethrow;
    }
  }
}
