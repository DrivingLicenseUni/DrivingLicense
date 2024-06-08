
import '../model/courses_progress.dart';

class ProgressLogViewModel {
  final CoursesProgressModel _model;
  final Map<String, String> user;

  ProgressLogViewModel({required this.user})
      : _model = CoursesProgressModel();

  List<Map<String, dynamic>> get checkboxData => _model.checkboxData;

  void updateCheckboxValue(int index, bool value) {
    _model.checkboxData[index]['value'] = value;
  }

  String getCategory(int index) {
    return _model.checkboxData[index]['category'];
  }
}






