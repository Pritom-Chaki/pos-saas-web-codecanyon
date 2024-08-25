import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salespro_saas_admin/Repo/getSMSPackageRepo.dart';
import 'package:salespro_saas_admin/model/sms_subscription_plan_model.dart';

SMSPackageRepo smsRepo = SMSPackageRepo();
final smsPackageProvider = FutureProvider<List<SmsSubscriptionPlanModel>>((ref) => smsRepo.getAllSMSPackage());
