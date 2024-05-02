import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      // create collection if it doesn't exist
      await _firestore.collection("users").doc(id).set({
        "email": email,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
