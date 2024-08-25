import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import '../model/payment_verification_model.dart';

class PaymentVerificationRepo {
  Future<List<PaymentVerificationModel>> getAllPayments() async {
    List<PaymentVerificationModel> allPayments = [];

    await FirebaseDatabase.instance.ref('Admin Panel').child('Payment Verification').orderByKey().get().then((value) {
      for (var element in value.children) {
        var data = PaymentVerificationModel.fromJson(jsonDecode(jsonEncode(element.value)));
        data.key = element.key;
        allPayments.add(data);
      }
    });
    return allPayments;
  }
}
