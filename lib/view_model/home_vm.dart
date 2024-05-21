import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:license/data/remote/instructor_data.dart';
import 'package:license/data/remote/user_data.dart';
import 'package:license/res/types.dart';

class HomeViewModel extends ChangeNotifier {
  final StudentData _studentData = StudentData();
  final InstructorData _instructorData = InstructorData();

  Student? _currentStudent;

  Student? get currentStudent => _currentStudent;

  HomeViewModel() {
    fetchCurrentStudent();
  }

  Future<Instructor> getInstructorById(String id) async {
    return await _instructorData.getInstructor(id);
  }

  Future<Student?> fetchCurrentStudent() async {
    User? user = _studentData.currentUser;
    if (user != null) {
      _currentStudent = await _studentData.getStudentByEmail(user.email!);
      notifyListeners();

      return _currentStudent;
    }

    return null;
  }

  Future<bool> comparePassword(String password) async {
    return await _studentData.comparePassword(password);
  }

  Future<void> updatePhoneNumber(String studentId, String phoneNumber) async {
    _currentStudent =
        await _studentData.updatePhoneNumber(studentId, phoneNumber);
    notifyListeners();
  }
}
