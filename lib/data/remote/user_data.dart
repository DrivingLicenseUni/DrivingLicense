import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:license/res/types.dart";
import 'package:license/data/remote/instructor_data.dart';

import "../../model/appointments_card_data.dart";

class StudentData {
  final collectionName = "students";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final InstructorData _instructorData = InstructorData();

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<bool> comparePassword(String password) async {
    User? user = _auth.currentUser;
    if (user != null) {
      return await _auth.currentUser!
          .reauthenticateWithCredential(
        EmailAuthProvider.credential(email: user.email!, password: password),
      )
          .then((value) {
        return true;
      }).catchError((error) {
        return false;
      });
    }

    return false;
  }

  Future<Student?> updatePhoneNumber(
      String studentId, String phoneNumber) async {
    try {
      await _firestore.collection(collectionName).doc(studentId).update({
        "phoneNumber": phoneNumber,
      });
    } catch (e) {
      rethrow;
    }

    return await _firestore
        .collection(collectionName)
        .doc(studentId)
        .get()
        .then((value) {
      return Student(
        id: value.id,
        email: value.data()!["email"],
        fullName: value.data()!["fullName"],
        phoneNumber: value.data()!["phoneNumber"],
        role: value.data()!["role"] ?? "Student",
        instructorName: value.data()!["instructorName"],
        instructorId: value.data()!["instructorId"],
        profileImageUrl: value.data()!["image"],
      );
    });
  }

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
        role: doc.docs[0].data()["role"] ?? "Student",
        instructorName: doc.docs[0].data()["instructorName"],
        instructorId: doc.docs[0].data()["instructorId"],
        profileImageUrl: doc.docs[0].data()["image"],
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
        "image": "",
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getInstructorId() async {
    try {
      String studentId = await getStudentId();
      String instructorId = await _firestore
          .collection(collectionName)
          .doc(studentId)
          .get()
          .then((doc) => doc['instructorId']);

      return instructorId;
    } catch (e) {
      print('Error fetching instructorId: $e');
      throw e;
    }
  }

  Future<Map<DateTime, List<String>>> fetchAvailableTimeSlots() async {
    try {
      String instructorId = await getInstructorId();
      Instructor instructor = await _instructorData.getInstructor(instructorId);

      Map<DateTime, List<String>> availableTimeSlots = {};

      for (var day in instructor.availableTimes.keys) {
        var timeSlots = instructor.availableTimes[day];
        if (timeSlots is List<String>) {
          availableTimeSlots[DateTime.now().add(Duration(days: day))] = timeSlots;
        }
      }

      return availableTimeSlots;
    } catch (e) {
      print('Error fetching available time slots: $e');
      throw e;
    }
  }

  Future<void> addAppointment(DateTime selectedDate, String selectedTime) async {
    try {
      //String studentId="t5QFxL6kOJFV20Xl37cn";//get it from db
      String studentId = await getStudentId();

      DocumentSnapshot studentDoc = await _firestore.collection(collectionName).doc(studentId).get();
      if (!studentDoc.exists) {
        throw Exception("Student not found");
      }
      Map<String, dynamic> studentData = studentDoc.data() as Map<String, dynamic>;

      String studentName = studentData['fullName'];
      String studentProfileImage = studentData['image'];

      await _firestore.collection(collectionName).doc(studentId).collection('appointments').add({
        'date': selectedDate,
        'time': selectedTime,
        'title': studentName,
        'subtitle': selectedTime,
        'avatar': studentProfileImage,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CardData>> getBookedAppointments() async {
    try {
      String studentId = await getStudentId();
      // print(studentId);
      //String studentId="t5QFxL6kOJFV20Xl37cn";

      // Timestamp queryDate = Timestamp.fromDate(date);
      //
      // DateTime nextDay = date.add(Duration(days: 1));
      // Timestamp nextDayTimestamp = Timestamp.fromDate(nextDay);

      final snapshot = await _firestore
          .collection(collectionName)
          .doc(studentId)
          .collection('appointments')
      // .where('date', isGreaterThanOrEqualTo: queryDate, isLessThan: nextDayTimestamp)
          .get();

      final List<CardData> bookedAppointments = snapshot.docs.map((doc) {
        return CardData.fromFirestore(doc);
      }).toList();
      return bookedAppointments;
    } catch (e) {
      print('Error fetching booked appointments: $e');
      return [];
    }
  }

}
