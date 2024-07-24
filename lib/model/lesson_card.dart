import 'package:cloud_firestore/cloud_firestore.dart';

class LessonCardModel {
  final String date;
  final String time;
  final String instructorName;
  final String topic;
  final String paymentStatus;

  LessonCardModel({
    required this.date,
    required this.time,
    required this.instructorName,
    required this.topic,
    required this.paymentStatus,
  });

  factory LessonCardModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return LessonCardModel(
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      instructorName: data['instructorName'] ?? '',
      topic: data['topic'] ?? '',
      paymentStatus: data['paymentStatus'] ?? '',
    );
  }
}

class StudentModel {
  final String id;
  final String fullName;
  final String email;
  final String profileImageUrl;

  StudentModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImageUrl,
  });

  factory StudentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return StudentModel(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }
}
