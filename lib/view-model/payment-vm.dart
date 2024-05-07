import 'package:flutter/foundation.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

class PaymentViewModel {
  void initiatePayment() {
    InAppPayments.setSquareApplicationId('sandbox-sq0idb-8I2DwnowJng9G60i_7Bqqw');
    InAppPayments.startCardEntryFlow(
      onCardEntryCancel: () {},
      onCardNonceRequestSuccess: cardNonceRequestSuccess,
    );
  }
  void cardNonceRequestSuccess(CardDetails result) {
    if (kDebugMode) {
      print('Nonce: ${result.nonce}');
    }

    InAppPayments.completeCardEntry(
        onCardEntryComplete: () {}
    );
  }
}
