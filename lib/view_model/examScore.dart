import 'package:flutter/material.dart';
import 'package:license/model/exams.dart';
import '../res/enum.dart';

class QuizViewModel extends ChangeNotifier {
  SingingCharacter? _character;
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<QuizQuestion> _questions = [
    QuizQuestion(
      question: 'What does this sign mean?',
      image: 'assets/images/narrow.png',
      answerChoices: [
        SingingCharacter.approachingABridgeNarrowerThanTheCurrentRoad,
        SingingCharacter.doNotTurnLeft,
        SingingCharacter.doNotTurnRight,
        SingingCharacter.parkingLot,
      ],
      correctAnswer: SingingCharacter.approachingABridgeNarrowerThanTheCurrentRoad,
    ),
    QuizQuestion(
      question: 'What does another sign mean?',
      image: 'assets/images/round.png',
      answerChoices: [
        SingingCharacter.noVehicles,
        SingingCharacter.ringRoad,
        SingingCharacter.miniRoundAbout,
        SingingCharacter.roundAbout,
      ],
      correctAnswer: SingingCharacter.roundAbout,
    ),
  ];

  SingingCharacter? get character => _character;
  int get questionIndex => _currentQuestionIndex;
  int get quizScore => _score;
  QuizQuestion get currentQuestion => _questions[_currentQuestionIndex];
  int get totalQuestions => _questions.length;

  List<SingingCharacter> get currentAnswerChoices => currentQuestion.answerChoices;

  Function(int score, int totalQuestions)? onSubmitQuiz;
  Function()? onNextQuestion;

  void setCharacter(SingingCharacter? value) {
    _character = value;
    notifyListeners();
  }

  void submitQuiz(BuildContext context) {
    if (_character != null) {
      if (_character == currentQuestion.correctAnswer) {
        _score++;
      }
      if (onSubmitQuiz != null) {
        onSubmitQuiz!(_score, _questions.length);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an answer before submitting the exam.'),
        ),
      );
    }
    notifyListeners();
  }

  void nextQuestion(BuildContext context) {
    if (_character != null) {
      if (_character == currentQuestion.correctAnswer) {
        _score++;
      }
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _character = null;
        if (onNextQuestion != null) {
          onNextQuestion!();
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an answer before moving to the next question.'),
        ),
      );
    }
    notifyListeners();
  }

  String enumToString(SingingCharacter value) {
    return value.toString().split('.').last.replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}').trim();
  }
}
