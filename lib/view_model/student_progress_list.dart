import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/participating_user.dart';

class StudentProgressListViewModel extends ChangeNotifier {
  List<UserModel> userList = [];

  StudentProgressListViewModel() {
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    try {
      final instructorId = await _getInstructorId();
      final snapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('instructorId', isEqualTo: instructorId)
          .get();

      userList = snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching students: $e');
    }
  }

 /* Future<String> _getInstructorId() async {
    //Static instructor ID for testing
    return "3QF7Kae5dh33mUqKPZNp";
  }*/

  Future<String> _getInstructorId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('No user logged in');

    final instructorSnapshot = await FirebaseFirestore.instance
        .collection('instructors')
        .where('email', isEqualTo: user.email)
        .limit(1)
        .get();

    if (instructorSnapshot.docs.isEmpty) throw Exception('Instructor not found');

    return instructorSnapshot.docs[0].id;
  }


}
