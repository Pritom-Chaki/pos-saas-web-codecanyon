import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../currency.dart';
import '../model/personal_information_model.dart';

class ProfileRepo {
  Future<PersonalInformationModel> getDetails({required String userID}) async {
    PersonalInformationModel personalInfo = PersonalInformationModel(
        companyName: 'Loading...',
        businessCategory: 'Loading...',
        countryName: 'Loading...',
        language: 'Loading...',
        phoneNumber: 'Loading...',
        pictureUrl: 'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_960_720.png',
        currency: '\$',
        currentLocale: 'en');
    final userRef = FirebaseDatabase.instance.ref(userID).child('Personal Information');

    final model = await userRef.get();
    userRef.keepSynced(true);
    var data = jsonDecode(jsonEncode(model.value));
    if (data == null) {
      return personalInfo;
    } else {
      return PersonalInformationModel.fromJson(data);
    }
  }
}
