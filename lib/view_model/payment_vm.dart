import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

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

  void cardNonceRequestSuccess(CardDetails result) {
    if (kDebugMode) {
      print('Nonce: ${result.nonce}');
    }

    Navigator.pushReplacementNamed(_context, '/select-instructor');

    InAppPayments.completeCardEntry(onCardEntryComplete: () {});
  }
}
