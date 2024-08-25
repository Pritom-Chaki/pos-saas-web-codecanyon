class SubscriptionRequestModel {
  late String subscriptionName, transactionNumber, note, attachment, userId, status, id;
  dynamic phoneNumber, duration;
  late int amount;
  String? companyName;
  String? pictureUrl;
  String? businessCategory;
  String? language;
  String? countryName;
  String? approvedDate;

  SubscriptionRequestModel(
      {required this.subscriptionName,
      required this.transactionNumber,
      required this.note,
      required this.attachment,
      required this.userId,
      required this.duration,
      required this.approvedDate,
      required this.amount});
  // Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
  //   'id': DateTime.now().toString(),
  //   'userId': userId,
  //   'subscriptionName': subscriptionPlanModel.subscriptionName,
  //   'subscriptionDuration': subscriptionPlanModel.duration,
  //   'subscriptionPrice': subscriptionPlanModel.offerPrice > 0 ? subscriptionPlanModel.offerPrice : subscriptionPlanModel.subscriptionPrice,
  //   'transactionNumber': transactionNumber,
  //   'note': note,
  //   'status': 'pending',
  //   'attachment': attachment,
  //   'phoneNumber': phoneNumber,
  //   'companyName': companyName,
  //   'pictureUrl': pictureUrl,
  //   'businessCategory': businessCategory,
  //   'language': language,
  //   'countryName': countryName,
  // };

  SubscriptionRequestModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    subscriptionName = json['subscriptionName'];
    duration = json['subscriptionDuration'];
    transactionNumber = json['transactionNumber'];
    amount = json['subscriptionPrice'];
    note = json['note'];
    status = json['status'];
    attachment = json['attachment'];
    phoneNumber = json['phoneNumber'];
    companyName = json['companyName'];
    pictureUrl = json['pictureUrl'];
    businessCategory = json['businessCategory'];
    language = json['language'];
    countryName = json['countryName'];
    approvedDate = json['approvedDate'];
  }
}
