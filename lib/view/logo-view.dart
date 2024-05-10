import 'package:flutter/material.dart';
import 'dart:async';

class LogoView extends StatefulWidget {
  const LogoView({super.key});

  @override
  _LogoViewState createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), navigateToOnboardingPage);
  }

  void navigateToOnboardingPage() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/onboarding-view');
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
