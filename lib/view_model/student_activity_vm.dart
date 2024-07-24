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

  Stream<List<LessonCardModel>> fetchStudentLessons(String studentId) {
    return _firestore
        .collection('lessons')
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LessonCardModel.fromFirestore(doc))
            .toList());
  }
}
