import 'package:firebase_auth/firebase_auth.dart';
import 'package:license/model/signup.dart';
import 'package:license/res/types.dart';

class CreateAccountViewModel {
  final SignUpModel _signUpModel = SignUpModel();

  Future<void> createStudentWithEmailAndPassword(
      {required String email,
      required String password,
      required String id}) async {
    try {
      await _signUpModel.createStudentWithEmailAndPassword(
          email: email, password: password, id: id);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> addStudentToDatabase({required Student student}) async {
    try {
      await _signUpModel.addStudentToDatabase(student);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
