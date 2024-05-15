class Instructor {
  final String id;
  final String name;
  final String image;
  final String desc;
  final String role;

  Instructor(
      {required this.id,
      required this.name,
      required this.image,
      required this.desc,
      required this.role});
}

class Student {
  String fullName;
  String email;
  String phoneNumber;
  String id;
  String role;  

  Student({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.id,
    required this.role
  });
}
