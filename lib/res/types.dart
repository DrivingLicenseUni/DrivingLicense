class Instructor {
  final String id;
  final String name;
  final String email;
  final String image;
  final String desc;
  final Map<int, dynamic> availableTimes;

  Instructor({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.desc,
    required this.availableTimes,
  });

  Instructor copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
    String? desc,
    Map<int, dynamic>? availableTimes,
  }) {
    return Instructor(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      desc: desc ?? this.desc,
      availableTimes: availableTimes ?? this.availableTimes,
    );
  }
}

class Student {
  String fullName;
  String email;
  String phoneNumber;
  String id;
  String? instructorName;
  String? instructorId;

  Student({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.id,
    this.instructorName,
    this.instructorId,
  });
}
