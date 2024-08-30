import 'package:salespro_admin/model/product_model.dart';

class PurchaseTransactionModel {
  late String customerName, customerPhone, customerAddress,customerGst, customerType, invoiceNumber, purchaseDate;
  dynamic totalAmount;
  dynamic dueAmount;
  dynamic returnAmount;
  dynamic discountAmount;

  String? key;

  bool? isPaid;
  String? paymentType;
  List<ProductModel>? productList;

  PurchaseTransactionModel({
    required this.customerName,
    required this.customerType,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerGst,
    required this.invoiceNumber,
    required this.purchaseDate,
    this.dueAmount,
    this.totalAmount,
    this.returnAmount,
    this.discountAmount,
    this.isPaid,
    this.paymentType,
    this.productList,
    this.key,
  });

  PurchaseTransactionModel.fromJson(Map<dynamic, dynamic> json) {
    customerName = json['customerName'] as String;
    customerPhone = json['customerPhone'].toString();
    invoiceNumber = json['invoiceNumber'].toString();
    customerAddress = json['customerAddress'] ?? '';
    customerGst = json['customerGst'] ?? '';
    customerType = json['customerType'].toString();
    purchaseDate = json['purchaseDate'].toString();
    totalAmount = json['totalAmount'] ?? 0;
    discountAmount = json['discountAmount'] ?? 0;
    dueAmount = json['dueAmount'] ?? 0;
    returnAmount = json['returnAmount'] ?? 0;
    isPaid = json['isPaid'];
    paymentType = json['paymentType'].toString();
    if (json['productList'] != null) {
      productList = <ProductModel>[];
      json['productList'].forEach((v) {
        productList!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'customerName': customerName,
    'customerPhone': customerPhone,
    'customerAddress': customerAddress,
    'customerType': customerType,
    'customerGst': customerGst,
    'invoiceNumber': invoiceNumber,
    'purchaseDate': purchaseDate,
    'discountAmount': discountAmount,
    'totalAmount': totalAmount,
    'dueAmount': dueAmount,
    'returnAmount': returnAmount,
    'isPaid': isPaid,
    'paymentType': paymentType,
    'productList': productList?.map((e) => e.toJson()).toList(),
  };
}