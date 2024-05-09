import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:license/view_model/forgot_password_vm.dart';
import 'package:license/res/colors.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<ForgotPasswordViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 35.0, top: 10),
            child: Icon(
              Icons.hotel_class,
              color: AppColors.primary,
              size: 50,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            const Text(
              "Forgot password?",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Don’t worry! It happens. Please enter the email associated with your account.",
              style: TextStyle(fontSize: 20, color: AppColors.placeholder),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Email address",
                  hintText: "Enter your email address",
                  border: const OutlineInputBorder(),
                  focusColor: AppColors.primary,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.primary, width: 2.0),
                  ),
                  labelStyle: TextStyle(color: AppColors.black)),
            ),
            const SizedBox(height: 25),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isNotEmpty) {
                      await viewModel.sendPasswordResetEmail(
                          emailController.text, context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please enter an email address')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Send Link",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  child: RichText(
                    text: TextSpan(
                      text: 'Remember password? ',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
