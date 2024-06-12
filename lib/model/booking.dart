import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentData {
  final String instructorName;
  final String instructorEmail;
  final DateTime dateTime;
  final String timeSlot;

  AppointmentData({
    required this.instructorName,
    required this.instructorEmail,
    required this.dateTime,
    required this.timeSlot,
  });

  factory AppointmentData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppointmentData(
      instructorName: data['instructorName'] ?? '',
      instructorEmail: data['instructorEmail'] ?? '',
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      timeSlot: data['timeSlot'] ?? '',
    );
  }
}