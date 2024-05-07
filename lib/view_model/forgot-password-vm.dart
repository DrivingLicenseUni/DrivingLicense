import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
      var querySnapshot = await _firestore.collection('users').where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        Navigator.of(context).pushNamedAndRemoveUntil('/passwordChanged', (route) => false);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email address not found. Please check and try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
  }
}