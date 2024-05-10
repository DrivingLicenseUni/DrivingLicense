import 'package:flutter/material.dart';
import '../res/colors.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding( // Added Padding here
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.app_shortcut, size: 130, color: AppColors.success),
              const SizedBox(height: 22),
              Text(
                "Check Your Email",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 25),
              Text (
                "We've sent a link to reset your password to your email. Please follow the link to set a new password.",textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.black,fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                          (Route<dynamic> route) => false
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Back to login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}