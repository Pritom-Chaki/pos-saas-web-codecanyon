import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../model/nid_verification_model.dart';

class NIDVerificationRepo {
  Future<List<NIDVerificationModel>> getAllNid() async {
    List<NIDVerificationModel> idCards = [];

    await FirebaseDatabase.instance.ref('Admin Panel').child('NID Verification').orderByKey().get().then((value) {
      for (var element in value.children) {
        var data = NIDVerificationModel.fromJson(jsonDecode(jsonEncode(element.value)));
        data.key = element.key;
        idCards.add(data);
      }
    });
    return idCards;
  }
}
