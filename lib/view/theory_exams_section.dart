import 'package:flutter/material.dart';
import 'package:license/view/exams_page.dart';

class ExamsPage extends StatelessWidget {
  final List<String> _examSamples = [
    '1st Exam',
    '2nd Exam',
    '3rd Exam',
    '4th Exam',
    '5th Exam',
    '6th Exam',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        _buildTheoryExamsSection(),
      ],
    );
  }

  Widget _buildTheoryExamsSection() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(35),
        itemCount: _examSamples.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(40),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamPage(title: "1st Exam"),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    _examSamples[index],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
