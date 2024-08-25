import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salespro_saas_admin/model/seller_info_model.dart';

import '../Repo/get_subscription_request_repo.dart';
import '../Repo/seller_info_repo.dart';
import '../model/subscription_request_model.dart';

GetSubscriptionRequestRepo getSubscriptionRequestRepo = GetSubscriptionRequestRepo();
final subscriptionRequestProvider = FutureProvider<List<SubscriptionRequestModel>>((ref) => getSubscriptionRequestRepo.getAllSubscriptionRequest());
