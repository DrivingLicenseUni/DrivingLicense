import 'package:license/view_model/progress_log.dart';

class CardListViewModel {
  final String userId;
  late final ProgressLogViewModel progressLogViewModel;

  CardListViewModel(this.userId) {
    progressLogViewModel = ProgressLogViewModel(userId: userId);
  }

  Future<List<CardViewData>> getCards() async {
    await progressLogViewModel.loadProgress();
    Map<String, double> categoryProgress = progressLogViewModel.categoryProgress;

    return [
      CardViewData(
        title: 'Pre-driving Knowledge',
        subtitle: '1 Lesson',
        progress: categoryProgress['Introduction'] ?? 0.0,
        avatarUrl: 'assets/images/Introduction.jpg',
      ),
      CardViewData(
        title: 'Right Turns',
        subtitle: '5 Lessons',
        progress: categoryProgress['Right turns'] ?? 0.0,
        avatarUrl: 'assets/images/right-turn.png',
      ),
      CardViewData(
        title: 'Left Turns',
        subtitle: '5 Lessons',
        progress: categoryProgress['Left turns'] ?? 0.0,
        avatarUrl: 'assets/images/left-turn.png',
      ),
      CardViewData(
        title: 'Reverse Focus',
        subtitle: '3 Lessons',
        progress: categoryProgress['Reverse Focus'] ?? 0.0,
        avatarUrl: 'assets/images/Reverse-focus.webp',
      ),
      CardViewData(
        title: 'Traffic circle',
        subtitle: '4 Lessons',
        progress: categoryProgress['Traffic circle'] ?? 0.0,
        avatarUrl: 'assets/images/traffic-circle.webp',
      ),
      CardViewData(
        title: 'Revision',
        subtitle: '6 Lessons',
        progress: categoryProgress['Revision'] ?? 0.0,
        avatarUrl: 'https://via.placeholder.com/50',
      ),
    ];
  }
}

class CardViewData {
  final String title;
  final String subtitle;
  final double progress;
  final String avatarUrl;

  CardViewData({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.avatarUrl,
  });
}

