import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:license/view/home_dummy.dart";
import "package:license/view/sign_in.dart";

class SigninAuth extends StatelessWidget {
  const SigninAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
