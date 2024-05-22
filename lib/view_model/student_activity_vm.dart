import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:license/model/lesson_card.dart';

class StudentViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<StudentModel?> fetchStudentData(String studentId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('students').doc(studentId).get();
      if (doc.exists) {
        return StudentModel.fromFirestore(doc);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching student data: $e');
      return null;
    }
  }

  Future<List<LessonCardModel>> fetchStudentLessons(String studentId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('students')
          .doc(studentId)
          .collection('lessons')
          .get();
      return snapshot.docs
          .map((doc) => LessonCardModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching student lessons: $e');
      return [];
    }
  }
}
