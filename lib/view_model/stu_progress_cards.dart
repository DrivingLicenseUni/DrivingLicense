import 'package:license/model/progress_card_data.dart';
class CardListViewModel {
  List<ProgressCardData> getCards() {
    return [
      ProgressCardData(
        title: 'Pre-driving Knowledge',
        subtitle: '1 Lesson',
        progress: 0.1,
        avatarUrl: 'assets/images/Introduction.jpg',
      ),
      ProgressCardData(
        title: 'Right Turns',
        subtitle: '5 Lessons',
        progress: 0.2,
        avatarUrl: 'assets/images/right-turn.png',
      ),
      ProgressCardData(
        title: 'Left Turns',
        subtitle: '5 Lessons',
        progress: 0.3,
        avatarUrl: 'assets/images/left-turn.png',
      ),
      ProgressCardData(
        title: 'Reverse Focus',
        subtitle: '3 Lessons',
        progress: 0.4,
        avatarUrl: 'assets/images/Reverse-focus.webp',
      ),
      ProgressCardData(
        title: 'Traffic circle',
        subtitle: '4 Lessons',
        progress: 0.5,
        avatarUrl: 'assets/images/traffic-circle.webp',
      ),
      ProgressCardData(
        title: 'Revision',
        subtitle: '6 Lessons',
        progress: 0.6,
        avatarUrl: 'https://via.placeholder.com/50',
      ),
    ];
  }
}