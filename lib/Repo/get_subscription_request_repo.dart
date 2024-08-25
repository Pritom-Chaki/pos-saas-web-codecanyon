import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../model/subscription_request_model.dart';

class GetSubscriptionRequestRepo {
  Future<List<SubscriptionRequestModel>> getAllSubscriptionRequest() async {
    List<SubscriptionRequestModel> requestList = [];

    await FirebaseDatabase.instance.ref('Admin Panel').child('Subscription Update Request').orderByKey().get().then((value) {
      for (var element in value.children) {
        var data = SubscriptionRequestModel.fromJson(jsonDecode(jsonEncode(element.value)));
        requestList.add(data);
      }
    });
    return requestList;
  }
}
