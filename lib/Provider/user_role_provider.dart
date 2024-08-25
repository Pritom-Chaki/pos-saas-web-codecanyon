import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Repo/get_user_role_repo.dart';
import '../model/user_role_model.dart';

UserRoleRepo repo = UserRoleRepo();
final userRoleProvider = FutureProvider.autoDispose<List<UserRoleModel>>((ref) => repo.getAllUserRole(userId: ''));
final allAdminUserRoleProvider = FutureProvider.autoDispose<List<UserRoleModel>>((ref) => repo.getAllUserRoleFromAdmin());
