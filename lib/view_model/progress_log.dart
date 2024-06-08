import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/courses_progress.dart';

class ProgressLogViewModel {
  final CoursesProgressModel _model;
  final String userId;

  ProgressLogViewModel({required this.userId}) : _model = CoursesProgressModel();

  List<Map<String, dynamic>> get checkboxData => _model.checkboxData;

  Future<void> loadProgress() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('students')
          .doc(userId)
          .collection('progress')
          .doc('progressLog')
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        _model.checkboxData = List<Map<String, dynamic>>.from(data['checkboxData']);
        _model.calculateCategoryProgress();
      }
    } catch (e) {
      print('Error loading progress: $e');
    }
  }

  Future<void> saveProgress() async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(userId)
          .collection('progress')
          .doc('progressLog')
          .set({
        'checkboxData': _model.checkboxData,
        'categoryProgress': _model.categoryProgress,
      });
    } catch (e) {
      print('Error saving progress: $e');
    }
  }

  void updateCheckboxValue(int index, bool value) {
    _model.checkboxData[index]['value'] = value;
    _model.calculateCategoryProgress();
    saveProgress();
  }

  Map<String, double> get categoryProgress => _model.categoryProgress;
}

