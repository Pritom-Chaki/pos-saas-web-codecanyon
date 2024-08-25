// ignore_for_file: unused_result

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/Provider/bank_info_provider.dart';
import 'package:salespro_saas_admin/Provider/paypal_info_provider.dart';
import 'package:salespro_saas_admin/model/bank_info_model.dart';
import 'package:salespro_saas_admin/model/paypal_info_model.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class PaymentSettings extends StatefulWidget {
  const PaymentSettings({super.key});

  static const String route = '/payment_settings';

  @override
  State<PaymentSettings> createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends State<PaymentSettings> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController swiftCodeController = TextEditingController();
  TextEditingController bankCurrencyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUserAndRestartApp();
  }

  void postDataIfNoData({required WidgetRef ref}) async {
    PaypalInfoModel paypalInfoModel = PaypalInfoModel(paypalClientId: 'paypalClientId', paypalClientSecret: 'paypalClientSecret', isLive: true);
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Paypal Info');
    adRef.set(paypalInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(paypalInfoProvider);
  }

  void postDataIfNoDataBank({required WidgetRef ref}) async {
    BankInfoModel paypalInfoModel =
        BankInfoModel(accountName: 'name', accountNumber: 'account Number', bankAccountCurrency: '', bankName: 'Bank Name', branchName: '', isActive: false, swiftCode: 'Code');
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Bank Info');
    adRef.set(paypalInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(paypalInfoProvider);
  }

  void postStripeDataIfNoData({required WidgetRef ref}) async {
    StripeInfoModel stripeInfoModel = StripeInfoModel(stripePublishableKey: '', stripeSecretKey: '', isLive: false, stripeCurrency: 'USD');
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Stripe Info');
    adRef.set(stripeInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(stripeInfoProvider);
  }

  void postSSLDataIfNoData({required WidgetRef ref}) async {
    SSLInfoModel sslInfoModel = SSLInfoModel(sslStoreId: "", sslStoreSecret: "", isLive: false);
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('SSL Info');
    adRef.set(sslInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(sslInfoProvider);
  }

  void postFlutterWaveDataIfNoData({required WidgetRef ref}) async {
    FlutterWaveInfoModel flutterWaveInfoModel = FlutterWaveInfoModel(flutterWavePublicKey: "", flutterWaveSecretKey: "", flutterWaveCurrency: "USD", flutterWaveEncKey: "", isLive: false);
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('FlutterWave Info');
    adRef.set(flutterWaveInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(flutterWaveInfoProvider);
  }

  void postRazorpayDataIfNoData({required WidgetRef ref}) async {
    RazorpayInfoModel razorpayInfoModel = RazorpayInfoModel(isLive: false, razorpayId: '', razorpayCurrency: '');
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Razorpay Info');
    adRef.set(razorpayInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(razorpayInfoProvider);
  }

  void postTapDataIfNoData({required WidgetRef ref}) async {
    TapInfoModel tapInfoModel = TapInfoModel(isLive: false, tapId: '');
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Tap Info');
    adRef.set(tapInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(tapInfoProvider);
  }

  void postKkiPayDataIfNoData({required WidgetRef ref}) async {
    KkiPayInfoModel kkiPayInfoModel = KkiPayInfoModel(isLive: false, kkiPayApiKey: '');
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('KkiPay Info');
    adRef.set(kkiPayInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(kkiPayInfoProvider);
  }

  void postPayStackDataIfNoData({required WidgetRef ref}) async {
    PayStackInfoModel payStackInfoModel = PayStackInfoModel(isLive: false, payStackPublicKey: '');
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('PayStack Info');
    adRef.set(payStackInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(payStackInfoProvider);
  }

  void postBillPlzIfNoData({required WidgetRef ref}) async {
    BillPlzInfoModel billPlzInfoModel = BillPlzInfoModel(isLive: false, billPlzSecretKey: '');
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Billplz Info');
    adRef.set(billPlzInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(billplzInfoProvider);
  }

  void postCashFreeIfNoData({required WidgetRef ref}) async {
    CashFreeInfoModel cashFreeInfoModel = CashFreeInfoModel(
      isLive: false,
      cashFreeClientId: '',
      cashFreeClientSecret: '',
      cashFreeApiVersion: '',
      cashFreeRequestId: '',
    );
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('CashFree Info');
    adRef.set(cashFreeInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(cashFreeInfoProvider);
  }

  void postIyzicoIfNoData({required WidgetRef ref}) async {
    IyzicoInfoModel iyzicoInfoModel = IyzicoInfoModel(isLive: false, iyzicoSecretKey: '', iyzicoPublicKey: '');
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Iyzico Info');
    adRef.set(iyzicoInfoModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(iyzicoInfoProvider);
  }

  bool isLive = false;
  bool isBankLive = false;
  String id = '';
  String secret = '';

  int i = 0;
  int j = 0;
  int stripe = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      drawer: const Drawer(
        child: SideBarWidget(
          index: 5,
          isTab: false,
        ),
      ),
      appBar: const GlobalAppbar(),
      body: Consumer(
        builder: (_, ref, watch) {
          final paypal = ref.watch(paypalInfoProvider);
          final bank = ref.watch(bankInfoProvider);
          final stripe = ref.watch(stripeInfoProvider);
          final sslCom = ref.watch(sslInfoProvider);
          final flutterWave = ref.watch(flutterWaveInfoProvider);
          final razorpay = ref.watch(razorpayInfoProvider);
          final tap = ref.watch(tapInfoProvider);
          final kkiPay = ref.watch(kkiPayInfoProvider);
          final payStack = ref.watch(payStackInfoProvider);
          final billplz = ref.watch(billplzInfoProvider);
          final cashFree = ref.watch(cashFreeInfoProvider);
          final iyzico = ref.watch(iyzicoInfoProvider);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Settings',
                      style: kTextStyle.copyWith(color: kTitleColor, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(
                      height: 1,
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 10.0),

                    ///_______Bank_info_________________________
                    bank.when(
                      data: (bankData) {
                        bankNameController.text = bankData.bankName;
                        branchNameController.text = bankData.branchName;
                        accountNumberController.text = bankData.accountNumber;
                        accountNameController.text = bankData.accountName;
                        swiftCodeController.text = bankData.swiftCode;
                        bankCurrencyController.text = bankData.bankAccountCurrency;
                        j == 0 ? isBankLive = bankData.isActive : null;
                        j++;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text('Bank Information', style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 130,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: const Text('Is Live'),
                                ),
                                const SizedBox(width: 20),
                                CupertinoSwitch(
                                  trackColor: Colors.red,
                                  value: isBankLive,
                                  onChanged: (value) {
                                    setState(() {
                                      isBankLive = value;
                                    });
                                  },
                                ),
                              ],
                            ),

                            ///________bank_Name____________________________
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 130,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: const Text('Bank Name'),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Bank Name',
                                    ),
                                    controller: bankNameController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            ///________Branch_name_____________________________
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 130,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: const Text('Branch Name'),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Branch Name',
                                    ),
                                    controller: branchNameController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            ///________Account_name_____________________________
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 130,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: const Text('Account Name'),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Account Name',
                                    ),
                                    controller: accountNameController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            ///________Account_Number____________________________
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 130,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: const Text('Account Number'),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Account Number',
                                    ),
                                    controller: accountNumberController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            ///________SWIFT_CODE_____________________________
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 130,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: const Text('SWIFT Code'),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter SWIFT Code',
                                    ),
                                    controller: swiftCodeController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            ///________Currency_____________________________
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 130,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: const Text('Bank Currency'),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 500,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Bank Account Currency',
                                    ),
                                    controller: bankCurrencyController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            ///_________Buttons_____________________________________
                            SizedBox(
                              width: 650,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      Navigator.pop(context);
                                      const PaymentSettings().launch(context);
                                    }),
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Cancel',
                                            style: kTextStyle.copyWith(color: kWhiteTextColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () async {
                                      EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                      BankInfoModel bankInfo = BankInfoModel(
                                        bankName: bankNameController.text,
                                        branchName: branchNameController.text,
                                        accountName: accountNameController.text,
                                        accountNumber: accountNumberController.text,
                                        swiftCode: swiftCodeController.text,
                                        bankAccountCurrency: bankCurrencyController.text,
                                        isActive: isBankLive,
                                      );
                                      final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Bank Info');
                                      await adRef.set(bankInfo.toJson());
                                      EasyLoading.showSuccess('Added Successfully');

                                      ///____provider_refresh____________________________________________
                                      ref.refresh(bankInfoProvider);
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Save',
                                            style: kTextStyle.copyWith(color: kWhiteTextColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                      error: (e, stack) {
                        print("Error: $e"); // Print the error message
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postDataIfNoDataBank(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________Paypal_info___________________________
                    paypal.when(
                      data: (reports) {
                        i == 0 ? isLive = reports.isLive : null;
                        i == 0 ? id = reports.paypalClientId : null;
                        i == 0 ? secret = reports.paypalClientSecret : null;
                        i++;
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('PayPal:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('PayPal Clint Id'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.paypalClientId,
                                      onChanged: (value) {
                                        id = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('PayPal Clint Secret'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.paypalClientSecret,
                                      onChanged: (value) {
                                        secret = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        if (reports.isLive != isLive || reports.paypalClientId != id || reports.paypalClientSecret != secret) {
                                          EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                          final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Paypal Info');
                                          await adRef.update({
                                            'isLive': isLive,
                                            'paypalClientId': id,
                                            'paypalClientSecret': secret,
                                          });
                                          EasyLoading.showSuccess('Added Successfully');

                                          ///____provider_refresh____________________________________________
                                          ref.refresh(paypalInfoProvider);
                                        } else {
                                          EasyLoading.showError('No change found!');
                                        }
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        print("paypal: $e");
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postDataIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________Stripe_info___________________________
                    stripe.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('Stripe:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Stripe Publishable Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.stripePublishableKey,
                                      onChanged: (value) {
                                        reports.stripePublishableKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Stripe Secret Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.stripeSecretKey,
                                      onChanged: (value) {
                                        reports.stripeSecretKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Stripe Currency'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.stripeCurrency,
                                      onChanged: (value) {
                                        reports.stripeCurrency = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Stripe Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(paypalInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postStripeDataIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________SSL_info___________________________
                    sslCom.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('SSL Commerz:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Store ID'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.sslStoreId,
                                      onChanged: (value) {
                                        reports.sslStoreId = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Store Password'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.sslStoreSecret,
                                      onChanged: (value) {
                                        reports.sslStoreSecret = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('SSL Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(sslInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postSSLDataIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________Flutterwave_info___________________________
                    flutterWave.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('Flutter Wave:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Public Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.flutterWavePublicKey,
                                      onChanged: (value) {
                                        reports.flutterWavePublicKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Secret Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.flutterWaveSecretKey,
                                      onChanged: (value) {
                                        reports.flutterWaveSecretKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Encryption Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.flutterWaveEncKey,
                                      onChanged: (value) {
                                        reports.flutterWaveEncKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('FlutterWave Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(flutterWaveInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postFlutterWaveDataIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________Razorpay_info___________________________
                    razorpay.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('Razorpay:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Razorpay Id'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.razorpayId,
                                      onChanged: (value) {
                                        reports.razorpayId = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Currency'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.razorpayCurrency,
                                      onChanged: (value) {
                                        reports.razorpayCurrency = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Razorpay Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(razorpayInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postRazorpayDataIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________Tap_info___________________________
                    tap.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('Tap:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Public Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.tapId,
                                      onChanged: (value) {
                                        reports.tapId = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Tap Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(tapInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postTapDataIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________kkipay_info___________________________
                    kkiPay.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('Kki Pay:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Public Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.kkiPayApiKey,
                                      onChanged: (value) {
                                        reports.kkiPayApiKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('KkiPay Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(kkiPayInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postKkiPayDataIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________Paystack_info___________________________
                    payStack.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('PayStack:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Public Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.payStackPublicKey,
                                      onChanged: (value) {
                                        reports.payStackPublicKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('PayStack Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(payStackInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postPayStackDataIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________BillPlz_info___________________________
                    billplz.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('BillPlz:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Secret Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.billPlzSecretKey,
                                      onChanged: (value) {
                                        reports.billPlzSecretKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Billplz Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(billplzInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postBillPlzIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________CashFree_info___________________________
                    cashFree.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('CashFree:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Client Id'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.cashFreeClientId,
                                      onChanged: (value) {
                                        reports.cashFreeClientId = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Client Secret'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.cashFreeClientSecret,
                                      onChanged: (value) {
                                        reports.cashFreeClientSecret = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('API Version'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.cashFreeApiVersion,
                                      onChanged: (value) {
                                        reports.cashFreeApiVersion = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Request ID'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.cashFreeRequestId,
                                      onChanged: (value) {
                                        reports.cashFreeRequestId = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('CashFree Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(cashFreeInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postCashFreeIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    ///_________Iyzico_info___________________________
                    iyzico.when(
                      data: (reports) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text('Iyzico:', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Is Live'),
                                  ),
                                  const SizedBox(width: 20),
                                  CupertinoSwitch(
                                    trackColor: Colors.red,
                                    value: reports.isLive,
                                    onChanged: (value) {
                                      setState(() {
                                        reports.isLive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Public Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.iyzicoPublicKey,
                                      onChanged: (value) {
                                        reports.iyzicoPublicKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Secret Key'),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      initialValue: reports.iyzicoSecretKey,
                                      onChanged: (value) {
                                        reports.iyzicoSecretKey = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.pop(context);
                                        const PaymentSettings().launch(context);
                                      }),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                        final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Iyzico Info');
                                        await adRef.set(reports.toJson());
                                        EasyLoading.showSuccess('Added Successfully');

                                        ///____provider_refresh____________________________________________
                                        ref.refresh(iyzicoInfoProvider);
                                      },
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Save',
                                              style: kTextStyle.copyWith(color: kWhiteTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                      error: (e, stack) {
                        if (e.toString().contains("TypeError: null: type 'Null' is not a subtype of type 'Map<dynamic, dynamic>'")) {
                          postIyzicoIfNoData(ref: ref);
                        }
                        return Center(
                          child: Text(e.toString()),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
