class Instructor {
  final String id;
  final String name;
  final String email;
  final String image;
  final String desc;
  final String role;
  final Map<int, dynamic> availableTimes;

  Instructor(
      {required this.id,
      required this.name,
      required this.email,
      required this.image,
      required this.desc,
      required this.availableTimes,
      required this.role});

  Instructor copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
    String? desc,
    String? role,
    Map<int, dynamic>? availableTimes,
  }) {
    return Instructor(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      desc: desc ?? this.desc,
      role: role ?? this.role,
      availableTimes: availableTimes ?? this.availableTimes,
    );
  }
}

class Student {
  String fullName;
  String email;
  String phoneNumber;
  String id;
  String role;
  String? instructorName;
  String? instructorId;
  final String profileImageUrl;

  Student({
    required this.id,
    required this.role,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.instructorName,
    required this.instructorId,
    required this.profileImageUrl,
  });
}

class SignData {
  final String title;
  final String image;
  final String description;
  final String header;

  SignData({
    required this.title,
    required this.image,
    required this.description,
    required this.header,
  });
}
