import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/remote/user_data.dart';
import '../res/types.dart';

class HomeViewModel extends ChangeNotifier {
  final StudentData _studentData = StudentData();

  Student? _currentStudent;

  Student? get currentStudent => _currentStudent;

  HomeViewModel() {
    _fetchCurrentStudent();
  }

  Future<void> _fetchCurrentStudent() async {
    User? user = _studentData.currentUser;
    if (user != null) {
      _currentStudent = await _studentData.getStudentByEmail(user.email!);
      notifyListeners();
    }
  }
}
