class CoursesProgressModel {
  late List<Map<String, dynamic>> checkboxData;

  CoursesProgressModel() {
    checkboxData = [
      {'category': 'Introduction', 'title': 'Basics of car', 'value': false},
      {'category': 'Right turns', 'title': 'Focus mirror', 'value': false},
      {'category': 'Right turns', 'title': 'Turns', 'value': false},
      {'category': 'Right turns', 'title': 'Break on turn', 'value': false},
      {'category': 'Right turns', 'title': 'signs', 'value': false},
      {'category': 'Right turns', 'title': 'Revision', 'value': false},
      {'category': 'Left turns', 'title': 'Basics of car', 'value': false},
      {'category': 'Left turns', 'title': 'Focus mirror', 'value': false},
      {'category': 'Left turns', 'title': 'Break on turn', 'value': false},
      {'category': 'Left turns', 'title': 'signs', 'value': false},
      {'category': 'Left turns', 'title': 'Revision', 'value': false},
    ];
  }
}
