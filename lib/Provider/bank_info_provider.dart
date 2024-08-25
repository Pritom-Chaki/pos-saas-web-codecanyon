import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salespro_saas_admin/Repo/bank_info_repo.dart';
import 'package:salespro_saas_admin/model/bank_info_model.dart';

BankInfoRepo bankRepo = BankInfoRepo();
final bankInfoProvider = FutureProvider<BankInfoModel>((ref) => bankRepo.getPaypalInfo());
