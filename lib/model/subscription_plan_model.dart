class SubscriptionPlanModel {
  SubscriptionPlanModel({
    required this.subscriptionName,
    required this.saleNumber,
    required this.purchaseNumber,
    required this.partiesNumber,
    required this.dueNumber,
    required this.duration,
    required this.products,
    required this.subscriptionPrice,
    required this.offerPrice,
  });

  String subscriptionName;
  dynamic saleNumber, purchaseNumber, partiesNumber, dueNumber, duration, products;
  dynamic subscriptionPrice, offerPrice;

  SubscriptionPlanModel.fromJson(Map<dynamic, dynamic> json)
      : subscriptionName = json['subscriptionName'] as String,
        saleNumber = json['saleNumber'] ?? 0,
        purchaseNumber = json['purchaseNumber']?? 0,
        partiesNumber = json['partiesNumber']?? 0,
        subscriptionPrice = json['subscriptionPrice']?? 0,
        dueNumber = json['dueNumber']?? 0,
        duration = json['duration']?? 0,
        products = json['products']?? 0,
        offerPrice = json['offerPrice']?? 0;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'subscriptionName': subscriptionName,
        'subscriptionPrice': subscriptionPrice,
        'saleNumber': saleNumber,
        'purchaseNumber': purchaseNumber,
        'partiesNumber': partiesNumber,
        'dueNumber': dueNumber,
        'duration': duration,
        'products': products,
        'offerPrice': offerPrice,
      };
}
