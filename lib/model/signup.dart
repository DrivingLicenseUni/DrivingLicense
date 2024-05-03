import "package:license/data/remote/user_data.dart";
import "package:license/res/types.dart";

class SignUpModel {
  final StudentData _userRepository = StudentData();

  Future<void> createStudentWithEmailAndPassword({
    required String email,
    required String password,
    required String id,
  }) async {
    bool doesIdExist = await _doesIdExist(id);

    if (doesIdExist) {
      throw Exception("User already exists");
    }

    try {
      await _userRepository.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addStudentToDatabase(Student student) async {
    bool doesIdExist = await _doesIdExist(student.id);

    if (doesIdExist) {
      await _userRepository.removeStudentFromAuth();
      throw Exception("User already exists");
    }

    Student? user = await _userRepository.getStudentByEmail(student.email);
    if (user != null) {
      throw Exception("Email already exists");
    }

    try {
      await _userRepository.addStudentToDatabase(student);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> _doesIdExist(String id) async {
    bool doesIdExist;

    try {
      doesIdExist = await _userRepository.isStudentInDatabase(id);
    } catch (e) {
      throw Exception(e.toString());
    }

    return doesIdExist;
  }
}
