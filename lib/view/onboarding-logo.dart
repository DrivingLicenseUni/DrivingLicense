import 'package:flutter/material.dart';
import 'dart:async';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), navigateToOnboardingPage);
  }

  void navigateToOnboardingPage() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/onboarding-page');
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
        child: Image.asset('assets/images/logo_gif.gif'),  // Your GIF asset
      ),
    );
  }
}
