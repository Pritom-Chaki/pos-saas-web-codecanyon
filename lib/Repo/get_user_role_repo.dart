import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import '../model/user_role_model.dart';

class UserRoleRepo {
  Future<List<UserRoleModel>> getAllUserRole({required String userId}) async {
    List<UserRoleModel> allUser = [];

    await FirebaseDatabase.instance.ref(userId).child('User Role').orderByKey().get().then((value) {
      for (var element in value.children) {
        var data = UserRoleModel.fromJson(jsonDecode(jsonEncode(element.value)));
        data.userKey = element.key;
        allUser.add(data);
      }
    });
    return allUser;
  }

  Future<List<UserRoleModel>> getAllUserRoleFromAdmin() async {
    List<UserRoleModel> allUser = [];

    await FirebaseDatabase.instance.ref('Admin Panel').child('User Role').orderByKey().get().then((value) {
      for (var element in value.children) {
        var data = UserRoleModel.fromJson(jsonDecode(jsonEncode(element.value)));
        data.userKey = element.key;
        allUser.add(data);
      }
    });
    return allUser;
  }
}
