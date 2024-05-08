import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordRemoteData {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
    try {
      if (!emailRegex.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email address. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      var querySnapshot = await _firestore.collection('students').where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        Navigator.of(context).pushNamedAndRemoveUntil('/password-ؤhanged', (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email address not found. Please check and try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
