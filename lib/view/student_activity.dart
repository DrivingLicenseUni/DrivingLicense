import 'package:flutter/material.dart';
import 'package:license/model/lesson_card.dart';
import 'package:license/view/card_view.dart';
import 'package:license/view_model/student_activity_vm.dart';
import 'package:provider/provider.dart';

class StudentActivityPage extends StatelessWidget {
  final String studentId;

  const StudentActivityPage({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final studentViewModel = context.watch<StudentViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<StudentModel?>(
        future: studentViewModel.fetchStudentData(studentId),
        builder: (context, AsyncSnapshot<StudentModel?> studentSnapshot) {
          if (studentSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (studentSnapshot.hasError) {
            return Center(child: Text('Error: ${studentSnapshot.error}'));
          } else if (!studentSnapshot.hasData || studentSnapshot.data == null) {
            return const Center(child: Text('No student data found'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder<List<LessonCardModel>>(
                    future: studentViewModel.fetchStudentLessons(studentId),
                    builder: (context,
                        AsyncSnapshot<List<LessonCardModel>> lessonSnapshot) {
                      if (lessonSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (lessonSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${lessonSnapshot.error}'));
                      } else if (!lessonSnapshot.hasData ||
                          lessonSnapshot.data!.isEmpty) {
                        return const Center(child: Text('No lessons found'));
                      } else {
                        return ListView.builder(
                          itemCount: lessonSnapshot.data!.length,
                          itemBuilder: (context, index) {
                            final lesson = lessonSnapshot.data![index];
                            return LessonCard(
                              date: lesson.date,
                              time: lesson.time,
                              instructorName: lesson.instructorName,
                              topic: lesson.topic,
                              paymentStatus: lesson.paymentStatus,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
