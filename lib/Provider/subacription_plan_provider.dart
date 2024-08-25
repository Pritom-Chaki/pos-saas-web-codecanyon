import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Repo/subscriptionPlanRepo.dart';
import '../model/subscription_plan_model.dart';

SubscriptionPlanRepo subscriptionRepo = SubscriptionPlanRepo();
final subscriptionPlanProvider = FutureProvider<List<SubscriptionPlanModel>>((ref) => subscriptionRepo.getAllSubscriptionPlans());
