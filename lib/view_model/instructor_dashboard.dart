import 'package:flutter/material.dart';
import 'package:license/data/remote/instructor_data.dart';
import 'package:license/res/types.dart';

class InstructorDashboardViewModel extends ChangeNotifier {
  final InstructorData _instructorData = InstructorData();

  List<Instructor> _instructors = [];
  List<Instructor> get instructors => _instructors;

  List<Student> _students = [];
  List<Student> get students => _students;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  InstructorDashboardViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _instructors = await _instructorData.getInstructors();
      _students = await _instructorData.getStudents();
    } catch (e) {
      print('Failed to load data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateInstructorRole(Instructor instructor, String newRole) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _instructorData.updateInstructorRole(instructor.id, newRole);
      final updatedInstructor = await _instructorData.getInstructor(instructor.id);
      _instructors = _instructors
          .map((i) => i.id == updatedInstructor.id ? updatedInstructor : i)
          .toList();
    } catch (e) {
      print('Failed to update instructor role: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateStudentRole(Student student, String newRole) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _instructorData.updateStudentRole(student.id, newRole);
      final updatedStudent = await _instructorData.getStudent(student.id);
      _students =
          _students.map((s) => s.id == updatedStudent.id ? updatedStudent : s).toList();
    } catch (e) {
      print('Failed to update student role: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}