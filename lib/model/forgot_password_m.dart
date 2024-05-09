import 'package:flutter/material.dart';
import 'package:license/data/remote/forgot_password_d.dart';

class ForgotPasswordModel {
  final ForgotPasswordRemoteData _remoteData;
  ForgotPasswordModel(this._remoteData);
  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    await _remoteData.sendPasswordResetEmail(email, context);
  }
}
