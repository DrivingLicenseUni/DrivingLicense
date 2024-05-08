class Instructor {
  final String id;
  final String name;
  final String image;
  final String desc;

  Instructor({
    required this.id,
    required this.name,
    required this.image,
    required this.desc,
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
