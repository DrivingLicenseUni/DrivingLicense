import 'package:firebase_auth/firebase_auth.dart';
import 'package:license/model/signup.dart';

class CreateAccountViewModel {
  final SignUpModel _signUpModel = SignUpModel();

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String id}) async {
    try {
      await _signUpModel.createUserWithEmailAndPassword(
          email: email, password: password, id: id);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> addUserToDatabase({
    required String email,
    required String fullName,
    required String phoneNumber,
    required String id,
  }) async {
    try {
      await _signUpModel.addUserToDatabase(
          email: email, fullName: fullName, phoneNumber: phoneNumber, id: id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
