class CoursesProgressModel {
  late List<Map<String, dynamic>> checkboxData;
  Map<String, double> categoryProgress = {};

  CoursesProgressModel() {
    checkboxData = [
      {'category': 'Introduction', 'title': 'Basics of car', 'value': false},
      {'category': 'Right turns', 'title': 'Focus mirror', 'value': false},
      {'category': 'Right turns', 'title': 'Turns', 'value': false},
      {'category': 'Right turns', 'title': 'Break on turn', 'value': false},
      {'category': 'Right turns', 'title': 'Signs', 'value': false},
      {'category': 'Right turns', 'title': 'Revision', 'value': false},
      {'category': 'Left turns', 'title': 'Basics of car', 'value': false},
      {'category': 'Left turns', 'title': 'Focus mirror', 'value': false},
      {'category': 'Left turns', 'title': 'Break on turn', 'value': false},
      {'category': 'Left turns', 'title': 'Signs', 'value': false},
      {'category': 'Left turns', 'title': 'Revision', 'value': false},
    ];
  }

  void calculateCategoryProgress() {
    Map<String, int> totalItems = {};
    Map<String, int> completedItems = {};

    for (var item in checkboxData) {
      String category = item['category'];
      if (!totalItems.containsKey(category)) {
        totalItems[category] = 0;
        completedItems[category] = 0;
      }
      totalItems[category] = totalItems[category]! + 1;
      if (item['value']) {
        completedItems[category] = completedItems[category]! + 1;
      }
    }

    categoryProgress = totalItems.map((category, count) {
      return MapEntry(category, completedItems[category]! / count);
    });
  }
}

