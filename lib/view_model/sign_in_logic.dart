// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:license/model/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final LoginData loginData = LoginData(email: '', password: '');

  void updateEmail(String email) {
    loginData.email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    loginData.password = password;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await loginData.login(loginData.email, loginData.password);
        Navigator.pushReplacementNamed(context, '/home-screen');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to login: $e'),
        ));
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await loginData.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign out: $e'),
      ));
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password should be at least 8 characters long';
    }
    return null;
  }
}
