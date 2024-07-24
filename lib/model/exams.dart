import '../res/enum.dart';

class QuizQuestion {
  final String question;
  final String image;
  final List<SingingCharacter> answerChoices;
  final SingingCharacter correctAnswer;

  QuizQuestion({
    required this.question,
    required this.image,
    required this.answerChoices,
    required this.correctAnswer,
  });
}
