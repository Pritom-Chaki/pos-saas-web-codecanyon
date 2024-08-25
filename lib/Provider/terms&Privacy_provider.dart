import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Repo/terms_&_privacy_repo.dart';
import '../model/terms&conditionModel.dart';

TermsAndPrivacyRepo bankRepo = TermsAndPrivacyRepo();
final privacyProvider = FutureProvider<TermsAanPrivacyModel>((ref) => bankRepo.getPrivacy());
final termsProvider = FutureProvider<TermsAanPrivacyModel>((ref) => bankRepo.getTerms());
