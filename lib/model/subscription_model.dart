class SubscriptionModel {
  SubscriptionModel({
    required this.subscriptionName,
    required this.subscriptionDate,
    required this.saleNumber,
    required this.purchaseNumber,
    required this.partiesNumber,
    required this.dueNumber,
    required this.duration,
    required this.products,
  });

  String subscriptionName, subscriptionDate;
  dynamic saleNumber, purchaseNumber, partiesNumber, dueNumber, duration, products;

  SubscriptionModel.fromJson(Map<dynamic, dynamic> json)
      : subscriptionName = json['subscriptionName'] as String,
        saleNumber = json['saleNumber'] ?? 0,
        subscriptionDate = json['subscriptionDate'] ?? 0,
        purchaseNumber = json['purchaseNumber']?? 0,
        partiesNumber = json['partiesNumber']?? 0,
        dueNumber = json['dueNumber'] ?? 0,
        duration = json['duration']?? 0,
        products = json['products']?? 0;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'subscriptionName': subscriptionName,
        'subscriptionDate': subscriptionDate,
        'saleNumber': saleNumber,
        'purchaseNumber': purchaseNumber,
        'partiesNumber': partiesNumber,
        'dueNumber': dueNumber,
        'duration': duration,
        'products': products,
      };
}
