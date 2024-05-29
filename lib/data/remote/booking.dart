// booking_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> confirmBooking(String studentId, String date, String time,
      String instructorId, String topic) async {
    // Store the booking details in the database
    try {
      await _firestore.collection('Lessons').add({
        'studentId': studentId,
        'date': date,
        'time': time,
        'instructorId': instructorId,
        'topic': topic,
      });

      // Send a confirmation message to the student
      // You can use a messaging service like Firebase Cloud Messaging (FCM) or any other messaging service
      // to send a notification or email to the student
      // For simplicity, we'll just print a message here
      print(
          'Booking confirmed for student $studentId on $date at $time with instructor $instructorId for topic $topic');
    } catch (e) {
      print('Error confirming booking: $e');
    }
  }
}
