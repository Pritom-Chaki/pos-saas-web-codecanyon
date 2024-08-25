import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salespro_saas_admin/Repo/payment_verification_repo.dart';
import 'package:salespro_saas_admin/model/payment_verification_model.dart';

PaymentVerificationRepo paymentRepo = PaymentVerificationRepo();
final paymentVerificationProvider = FutureProvider<List<PaymentVerificationModel>>((ref) => paymentRepo.getAllPayments());
