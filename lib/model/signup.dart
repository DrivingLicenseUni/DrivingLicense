import "package:license/repository/user_repository.dart";

class SignUpModel {
  final UserRepository _userRepository = UserRepository();

  Future<void> createUserWithEmailAndPassword({
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

  Future<void> addUserToDatabase({
    required String email,
    required String fullName,
    required String phoneNumber,
    required String id,
  }) async {
    bool doesIdExist = await _doesIdExist(id);

    if (doesIdExist) {
      await _userRepository.removeUserFromAuth();
      print("you suck");
      throw Exception("User already exists");
    }

    try {
      await _userRepository.addUserToDatabase(
          email: email, fullName: fullName, phoneNumber: phoneNumber, id: id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> _doesIdExist(String id) async {
    bool doesIdExist;

    try {
      doesIdExist = await _userRepository.isUserInDatabase(id);
    } catch (e) {
      throw Exception(e.toString());
    }

    return doesIdExist;
  }
}
