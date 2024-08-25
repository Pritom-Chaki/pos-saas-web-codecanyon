import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salespro_saas_admin/Repo/nid_verification_repo.dart';
import 'package:salespro_saas_admin/model/nid_verification_model.dart';

NIDVerificationRepo nidRepo = NIDVerificationRepo();
final nidVerificationProvider = FutureProvider<List<NIDVerificationModel>>((ref) => nidRepo.getAllNid());
