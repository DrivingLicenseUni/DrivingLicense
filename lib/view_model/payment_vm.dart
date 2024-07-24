import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentViewModel {
  final BuildContext _context;
  // context
  PaymentViewModel(this._context);

  void initiatePayment() {
    InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-8I2DwnowJng9G60i_7Bqqw');
    InAppPayments.startCardEntryFlow(
      onCardEntryCancel: () {},
      onCardNonceRequestSuccess: cardNonceRequestSuccess,
    );
  }

  void cardNonceRequestSuccess(CardDetails result) async {
    if (kDebugMode) {
      print('Nonce: ${result.nonce}');
    }

    // Check if user is logged in
    bool isLoggedIn = await isUserLoggedIn();

    // Navigate based on login status
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(_context, '/book-appointment');
    } else {
      Navigator.pushReplacementNamed(_context, '/select-instructor');
    }

    InAppPayments.completeCardEntry(onCardEntryComplete: () {});
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // Default to false if not found
  }
}
