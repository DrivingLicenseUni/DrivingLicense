import 'package:flutter/material.dart';
import 'package:license/model/forgot_password_m.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  final ForgotPasswordModel _model;
  ForgotPasswordViewModel(this._model);
  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    await _model.sendPasswordResetEmail(email, context);
  }
}
