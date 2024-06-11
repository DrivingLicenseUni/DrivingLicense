import 'package:flutter/material.dart';
import 'package:license/res/textstyle.dart';
import 'package:license/view_model/examScore.dart';
import '../res/enum.dart';
import 'package:license/view/exam_score.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final QuizViewModel viewModel = QuizViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.onSubmitQuiz = (score, totalQuestions) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ScorePage(score: score, totalQuestions: totalQuestions)),
      );
    };
    viewModel.onNextQuestion = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Theory page',
          style: AppTextStyles.headline,
        ),
        toolbarHeight: 83,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '1st Exam',
              style: AppTextStyles.title,
            ),
            Text(
              viewModel.currentQuestion.question,
              style: AppTextStyles.title,
            ),
            Image.asset(
              viewModel.currentQuestion.image,
              height: 200,
              width: 200,
            ),
            SizedBox(height: 135),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (var answerChoice in viewModel.currentAnswerChoices)
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            viewModel.enumToString(answerChoice),
                            style: AppTextStyles.title,
                          ),
                          leading: Radio<SingingCharacter>(
                            value: answerChoice,
                            groupValue: viewModel.character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                viewModel.setCharacter(value);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            Row(
              children: [
                Spacer(),
                if (viewModel.questionIndex == viewModel.totalQuestions - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, // Text color
                    ),
                    onPressed: () {
                      viewModel.submitQuiz(context);
                    },
                    child: Text('Submit'),
                  )
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, // Text color
                    ),
                    onPressed: () {
                      setState(() {
                        viewModel.nextQuestion(context);
                      });
                    },
                    child: Text('Next'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
