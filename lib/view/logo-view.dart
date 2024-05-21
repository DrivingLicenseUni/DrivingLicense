import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class LogoView extends StatefulWidget {
  final User? user;
  const LogoView({super.key, this.user});

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), navigateToOnboardingPage);
  }

  void navigateToOnboardingPage() {
    if (mounted) {
      if (widget.user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/home-screen');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Image.asset('assets/images/logo_gif.gif'),
      ),
    );
  }
}
