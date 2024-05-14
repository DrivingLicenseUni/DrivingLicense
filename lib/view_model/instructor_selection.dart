import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:license/model/select_instructor_model.dart';
import 'package:license/model/signup.dart';
import 'package:license/res/types.dart';

class InstructorSelectionViewModel {
  final InstructorModel _selectInstructorModel = InstructorModel();
  final StudentModel _studentModel = StudentModel();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Instructor>> getInstructors() async {
    try {
      return await _selectInstructorModel.getInstructors();
    } catch (e) {
      rethrow;
    }
  }

  Future<Instructor> getInstructor(String id) async {
    try {
      return await _selectInstructorModel.getInstructor(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<Instructor> getInstructorByEmail(String email) async {
    try {
      return await _selectInstructorModel.getInstructorByEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getStudentId() async {
    try {
      return await _studentModel.getStudentId();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addInstructorNameToStudent(
      String studentId, String instructorName, String instructorId) async {
    try {
      await _selectInstructorModel.addInstructorNameToStudent(
          studentId, instructorName, instructorId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cacheInstructors() async {
    await _selectInstructorModel.cacheInstructors();
  }

  List<Instructor> getCachedInstructors() {
    return _selectInstructorModel.getCachedInstructors();
  }

  Instructor? getCachedInstructor(String id) {
    return _selectInstructorModel.getCachedInstructor(id);
  }
}
