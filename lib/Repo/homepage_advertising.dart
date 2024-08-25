import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import '../model/homepage_image_model.dart';

class HomePageAdvertisingRepo {
  Future<List<HomePageAdvertisingModel>> getAllHomePageAdvertising() async {
    List<HomePageAdvertisingModel> advertisingList = [];
    await FirebaseDatabase.instance.ref().child('Admin Panel').child('Homepage Image').orderByKey().get().then((value) {
      for (var element in value.children) {
        advertisingList.add(HomePageAdvertisingModel.fromJson(jsonDecode(jsonEncode(element.value))));
      }
    });
    return advertisingList;
  }
}
