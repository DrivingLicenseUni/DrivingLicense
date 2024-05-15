class UserModel {
  final String title;
  final String subtitle;
  final String avatarText;

  UserModel({
    required this.title,
    required this.subtitle,
    required this.avatarText,
  });

  Map<String, String> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'avatarText': avatarText,
    };
  }
}


