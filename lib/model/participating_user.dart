import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String title;
  final String subtitle;
  final String avatarText;

  UserModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.avatarText,
  });

  Map<String, String> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'avatarText': avatarText,
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      title: data['fullName'] ?? '',
      subtitle: data['email'] ?? '',
      avatarText: data['fullName'].isNotEmpty ? data['fullName'][0] : '',
    );
  }
}

