class Instructor {
  final String id;
  final String name;
  final String email;
  final String image;
  final String desc;
  final Map<String, dynamic> availableTimes;

  Instructor({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.desc,
    required this.availableTimes,
  });
}

class Student {
  String fullName;
  String email;
  String phoneNumber;
  String id;

  Student({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.id,
  });
}
