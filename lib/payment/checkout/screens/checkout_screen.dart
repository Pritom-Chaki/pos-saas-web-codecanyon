import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salespro_admin/model/create_payment_response.dart';
import 'package:salespro_admin/model/grant_token_response.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool loading = false;
  TextEditingController amountController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();

  // Grant token
  Future<GrantTokenResponse> grantToken() async {
    final response = await http.post(
      Uri.parse(
          "https://tokenized.pay.bka.sh/v1.2.0-beta/tokenized/checkout/token/grant"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "username": "01752156079",
        "password": "!<+8Cb!k^@C"
      },
      body: Uint8List.fromList(
        utf8.encode(
          jsonEncode(
            {
              "app_key": "TyvaRsl9jCZ37daetzZ1lQeKtc",
              "app_secret":
                  "nQYx0fC5jDdN9DitOKPkDuYLOUqEVHVqMVA8RmGgqSxewtKsgsqX",
            },
          ),
        ),
      ),
    );

    if (response.statusCode == 200) {
      return GrantTokenResponse.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    return GrantTokenResponse(
      statusCode: "statusCode",
      statusMessage: "statusMessage",
      idToken: "idToken",
      tokenType: "tokenType",
      expiresIn: 123,
      refreshToken: "refreshToken",
    );
  }

  // Create payment
  Future<CreatePaymentResponse> createPayment({
    required String idToken,
    required String amount,
    required String invoiceNumber,
  }) async {
    final response = await http.post(
      Uri.parse(
          "https://tokenized.pay.bka.sh/v1.2.0-beta/tokenized/checkout/create"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": idToken,
        "X-App-Key": "TyvaRsl9jCZ37daetzZ1lQeKtc",
      },
      body: Uint8List.fromList(
        utf8.encode(
          jsonEncode(
            {
              "mode": "0011",
              "payerReference": "01752156079",
              "callbackURL": "https://tcean.store",
              "amount": amount,
              "currency": "BDT",
              "intent": "sale",
              "merchantInvoiceNumber": invoiceNumber
            },
          ),
        ),
      ),
    );

    if (response.statusCode == 200) {
      print("create payment: ${response.body}");
      return CreatePaymentResponse.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }

    return CreatePaymentResponse(
      paymentID: "paymentID",
      paymentCreateTime: "paymentCreateTime",
      transactionStatus: "transactionStatus",
      amount: "amount",
      currency: "currency",
      intent: "intent",
      merchantInvoiceNumber: "merchantInvoiceNumber",
      bkashURL: "bkashURL",
      callbackURL: "callbackURL",
      successCallbackURL: "successCallbackURL",
      failureCallbackURL: "failureCallbackURL",
      cancelledCallbackURL: "cancelledCallbackURL",
      statusCode: "statusCode",
      statusMessage: "statusMessage",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: const Color(0xffEE1284),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(hintText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: invoiceNumberController,
              decoration: const InputDecoration(hintText: "Invoice Number"),
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await grantToken().then((grantTokenResponse) async {
                  await createPayment(
                    idToken: grantTokenResponse.idToken,
                    amount: amountController.text,
                    invoiceNumber: invoiceNumberController.text,
                  ).then((createPaymentResponse) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.pushNamed(context,"RouteName.paymentScreen", arguments:  createPaymentResponse.bkashURL);
                  });
                });
              },
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Pay with Bkash"),
            ),
          ],
        ),
      ),
    );
  }
}
