import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salespro_saas_admin/Repo/homepage_advertising.dart';

import '../model/homepage_image_model.dart';

HomePageAdvertisingRepo advertisingRepo = HomePageAdvertisingRepo();
final homepageAdvertising = FutureProvider<List<HomePageAdvertisingModel>>((ref) => advertisingRepo.getAllHomePageAdvertising());
