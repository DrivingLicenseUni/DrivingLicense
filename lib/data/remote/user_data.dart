import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:license/res/types.dart";

class StudentData {
  final collectionName = "students";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String> getStudentId() async {
    String studentEmail = _auth.currentUser!.email!;

    String studentId = await _firestore
        .collection('students')
        .where('email', isEqualTo: studentEmail)
        .get()
        .then((value) => value.docs[0].id);

    return studentId;
  }

  Future<bool> isStudentInDatabase(String id) async {
    try {
      final doc = await _firestore.collection(collectionName).doc(id).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addInstructorNameToStudent(
      String studentId, String instructorName, String instructorId) async {
    try {
      await _firestore.collection(collectionName).doc(studentId).update({
        "instructorName": instructorName,
        "instructorId": instructorId,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<Student?> getStudentByEmail(String email) async {
    try {
      final doc = await _firestore
          .collection(collectionName)
          .where("email", isEqualTo: email)
          .get();
      Student student = Student(
        id: doc.docs[0].id,
        email: doc.docs[0].data()["email"],
        fullName: doc.docs[0].data()["fullName"],
        phoneNumber: doc.docs[0].data()["phoneNumber"],
        instructorName: doc.docs[0].data()["instructorName"],
        instructorId: doc.docs[0].data()["instructorId"],
      );
      return student;
    } catch (e) {
      return null;
    }
  }

  Future<void> removeStudentFromAuth() async {
    try {
      await _auth.currentUser!.delete();
    } catch (e) {
      rethrow;
    }
  }

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

  Future<void> addStudentToDatabase(Student student) async {
    try {
      await _firestore.collection(collectionName).doc(student.id).set({
        "email": student.email,
        "fullName": student.fullName,
        "phoneNumber": student.phoneNumber,
        "instructorName": "",
        "instructorId": "",
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
