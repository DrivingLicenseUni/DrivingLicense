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
                image: doc['image'],
                desc: doc['desc'],
                role: doc['role'],
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
        image: snapshot['image'],
        desc: snapshot['desc'],
        role: snapshot['role'],
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateInstructorRole(String id, String newRole) async {
    try {
      await _firestore.collection('instructors').doc(id).update({
        'role': newRole,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Student>> getStudents() async {
    try {
      final snapshot = await _firestore.collection('students').get();
      return snapshot.docs
          .map((doc) => Student(
                id: doc.id,
                email: doc['email'],
                fullName: doc['fullName'],
                phoneNumber: doc['phoneNumber'],
                role: doc['role'] ?? 'Student', // Provide a default value if 'role' is not present
              ))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Student> getStudent(String id) async {
    try {
      final snapshot = await _firestore.collection('students').doc(id).get();
      return Student(
        id: snapshot.id,
        email: snapshot['email'],
        fullName: snapshot['fullName'],
        phoneNumber: snapshot['phoneNumber'],
        role: snapshot['role'] ?? 'Student', // Provide a default value if 'role' is not present
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateStudentRole(String id, String newRole) async {
    try {
      await _firestore.collection('students').doc(id).update({
        'role': newRole,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}