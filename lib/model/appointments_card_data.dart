import 'package:cloud_firestore/cloud_firestore.dart';

class CardData {
  final String title;
  final String subtitle;
  final String avatar;
  final DateTime date;

  CardData({
    required this.title,
    required this.subtitle,
    required this.avatar,
    required this.date,
  });

  factory CardData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CardData(
      title: data['title'] ?? 'Appointment',
      subtitle: data['subtitle'],
      avatar: data['avatar'] ,
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}
