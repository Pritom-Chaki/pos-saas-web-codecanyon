class PersonalInformationModel {
  PersonalInformationModel({
    required this.phoneNumber,
    required this.companyName,
    required this.pictureUrl,
    required this.businessCategory,
    required this.language,
    required this.countryName,
    required this.saleInvoiceCounter,
    required this.purchaseInvoiceCounter,
    required this.dueInvoiceCounter,
    required this.shopOpeningBalance,
    required this.remainingShopBalance,
    required this.currency,
    required this.currentLocale,
  });

  PersonalInformationModel.fromJson(dynamic json) {
    phoneNumber = json['phoneNumber'];
    companyName = json['companyName'];
    pictureUrl = json['pictureUrl'];
    businessCategory = json['businessCategory'];
    language = json['language'];
    countryName = json['countryName'];
    //pc_cng
    saleInvoiceCounter = json['saleInvoiceCounter']?? 0;
    purchaseInvoiceCounter = json['purchaseInvoiceCounter']?? 0;
    dueInvoiceCounter = json['dueInvoiceCounter']?? 0;
    shopOpeningBalance = json['shopOpeningBalance'] ?? 0;
    remainingShopBalance = json['remainingShopBalance'] ?? 0;
    currency = json['currency'] ?? '\$';
    currentLocale = json['currentLocale'] ?? 'en';
  }

  late dynamic phoneNumber;
  late String companyName;
  late String pictureUrl;
  late String businessCategory;
  late String language;
  late String countryName;
  late int dueInvoiceCounter;
  late int saleInvoiceCounter;
  late int purchaseInvoiceCounter;
  late num shopOpeningBalance;
  late num remainingShopBalance;
  late String currency;
  late String currentLocale;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = phoneNumber;
    map['companyName'] = companyName;
    map['pictureUrl'] = pictureUrl;
    map['businessCategory'] = businessCategory;
    map['language'] = language;
    map['countryName'] = countryName;
    map['saleInvoiceCounter'] = saleInvoiceCounter;
    map['purchaseInvoiceCounter'] = purchaseInvoiceCounter;
    map['dueInvoiceCounter'] = dueInvoiceCounter;
    map['shopOpeningBalance'] = shopOpeningBalance;
    map['remainingShopBalance'] = remainingShopBalance;
    map['currency'] = currency;
    map['currentLocale'] = currentLocale;
    return map;
  }
}
