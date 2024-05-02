import 'package:firebase_auth/firebase_auth.dart';
import "package:license/repository/user_repository.dart";

class CreateAccountViewModel {
  final UserRepository _userRepository = UserRepository();

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _userRepository.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> addUserToDatabase(
      {required String email,
      required String fullName,
      required String phoneNumber,
      required String id}) async {
    try {
      await _userRepository.addUserToDatabase(
          email: email, fullName: fullName, phoneNumber: phoneNumber, id: id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
