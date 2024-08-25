import 'package:salespro_saas_admin/model/subscription_plan_model.dart';

class SubscriptionPostRequestModel {
  SubscriptionPlanModel subscriptionPlanModel;
  late String transactionNumber, note, attachment, userId;
  String phoneNumber;
  String companyName;
  String pictureUrl;
  String businessCategory;
  String language;
  String countryName;

  SubscriptionPostRequestModel({
    required this.subscriptionPlanModel,
    required this.transactionNumber,
    required this.note,
    required this.attachment,
    required this.userId,
    required this.phoneNumber,
    required this.businessCategory,
    required this.companyName,
    required this.pictureUrl,
    required this.countryName,
    required this.language,
  });

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'id': DateTime.now().toString(),
        'userId': userId,
        'subscriptionName': subscriptionPlanModel.subscriptionName,
        'subscriptionDuration': subscriptionPlanModel.duration,
        'subscriptionPrice': subscriptionPlanModel.offerPrice > 0 ? subscriptionPlanModel.offerPrice : subscriptionPlanModel.subscriptionPrice,
        'transactionNumber': transactionNumber,
        'note': note,
        'status': 'approved',
        'approvedDate': DateTime.now().toString(),
        'attachment': attachment,
        'phoneNumber': phoneNumber,
        'companyName': companyName,
        'pictureUrl': pictureUrl,
        'businessCategory': businessCategory,
        'language': language,
        'countryName': countryName,
      };
}
