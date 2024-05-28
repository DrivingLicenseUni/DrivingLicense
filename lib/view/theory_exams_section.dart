import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';

class TheoryPage extends StatefulWidget {
  @override
  _TheoryPageState createState() => _TheoryPageState();
}

class _TheoryPageState extends State<TheoryPage> {
  bool isSamplesSelected = true;

  final List<String> examSamples = [
    '1st Exam',
    '2nd Exam',
    '3rd Exam',
    '4th Exam',
    '5th Exam',
    '6th Exam',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theory Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          ToggleButtons(
            borderRadius: BorderRadius.circular(20),
            selectedColor: AppColors.black,
            fillColor:  AppColors.secondaryBlue,
            color: AppColors.black,
            borderColor: AppColors.placeholder,
            selectedBorderColor: AppColors.primary,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text('Signs'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text('Samples'),
              ),
            ],
            isSelected: [!isSamplesSelected, isSamplesSelected],
            onPressed: (index) {
              setState(() {
                isSamplesSelected = index == 1;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(35

              ),
              itemCount: examSamples.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Material(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(40),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {

                      },
                      child: Container(
                        padding: EdgeInsets.all(25),
                        child: Text(
                          examSamples[index],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}