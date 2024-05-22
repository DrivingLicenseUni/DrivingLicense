import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  final String date;
  final String time;
  final String instructorName;
  final String topic;
  final String paymentStatus;

  LessonCard({
    required this.date,
    required this.time,
    required this.instructorName,
    required this.topic,
    required this.paymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: $date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Time: $time'),
            SizedBox(height: 8.0),
            Text('Instructor: $instructorName'),
            SizedBox(height: 8.0),
            Text('Topic: $topic'),
            SizedBox(height: 8.0),
            Text('Payment Status: $paymentStatus'),
          ],
        ),
      ),
    );
  }
}