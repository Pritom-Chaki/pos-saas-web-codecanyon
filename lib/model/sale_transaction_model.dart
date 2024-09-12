import 'package:salespro_admin/model/product_model.dart';

import 'add_to_cart_model.dart';

class SaleTransactionModel {
  late String customerName, customerPhone, customerAddress, customerGst, customerType, customerImage, invoiceNumber, purchaseDate;
  double? totalAmount;
  double? dueAmount;
  double? returnAmount;
  double? serviceCharge;
  double? vat;
  double? discountAmount;
  double? lossProfit;
  num? totalQuantity;
  bool? isPaid;
  String? paymentType;
  List<AddToCartModel>? productList;
  String? sellerName;
  String? key;

  SaleTransactionModel({
    required this.customerName,
    required this.customerType,
    required this.customerPhone,
    required this.invoiceNumber,
    required this.purchaseDate,
    required this.customerAddress,
    required this.customerImage,
    required this.customerGst,
    this.dueAmount,
    this.totalAmount,
    this.returnAmount,
    this.vat,
    this.serviceCharge,
    this.discountAmount,
    this.isPaid,
    this.paymentType,
    this.productList,
    this.lossProfit,
    this.totalQuantity,
    this.sellerName,
    this.key,
  });

  SaleTransactionModel.fromJson(Map<dynamic, dynamic> json) {
    customerName = json['customerName']?? "Guest";
    customerPhone = json['customerPhone']?? "";
    customerAddress = json['customerAddress'] ?? '';
    customerGst = json['customerGst'] ?? '';
    customerImage =json['customerImage'] ??
        'https://firebasestorage.googleapis.com/v0/b/maanpos.appspot.com/o/Profile%20Picture%2Fblank-profile-picture-973460_1280.webp?alt=media&token=3578c1e0-7278-4c03-8b56-dd007a9befd3';
    invoiceNumber = json['invoiceNumber'] ?? "";
    customerType = json['customerType']?? "";
    purchaseDate = json['purchaseDate']?? "";
    totalAmount = double.parse(json['totalAmount'] != null ? json['totalAmount'].toString() : "0");
    discountAmount = double.parse(json['discountAmount']!= null ? json['discountAmount'].toString() : "0");
    serviceCharge = double.parse(json['serviceCharge']!= null ? json['serviceCharge'].toString() : "0");
    vat =double.parse(json['vat']!= null ? json['vat'].toString() : "0");
    lossProfit = double.parse(json['lossProfit']!= null ? json['lossProfit'].toString() : "0");
    totalQuantity = json['totalQuantity'] ?? 0;
    sellerName = json['sellerName'];
    dueAmount = double.parse(json['dueAmount']!= null ? json['dueAmount'].toString() : "0");
    returnAmount = double.parse(json['returnAmount']!= null ? json['returnAmount'].toString() : "0");
    isPaid = json['isPaid'] ?? false;
    paymentType = json['paymentType']?? '';
       
    if (json['productList'] != null) {
      productList = <AddToCartModel>[];
      json['productList'].forEach((v) {
        productList!.add(AddToCartModel.fromJson(v));
      });
    } else {
      productList = [];
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'customerName': customerName,
        'customerPhone': customerPhone,
        'customerAddress': customerAddress,
        'customerGst': customerGst,
        'customerType': customerType,
        'customerImage': customerImage,
        'invoiceNumber': invoiceNumber,
        'purchaseDate': purchaseDate,
        'discountAmount': discountAmount,
        'vat': vat,
        'serviceCharge': serviceCharge,
        'totalAmount': totalAmount,
        'dueAmount': dueAmount,
        'sellerName': sellerName,
        'returnAmount': returnAmount,
        'lossProfit': lossProfit,
        'totalQuantity': totalQuantity,
        'isPaid': isPaid,
        'paymentType': paymentType,
        'productList':productList== null || productList!.isEmpty ?[] : productList?.map((e) => e.toJson()).toList() ,
      };
}
