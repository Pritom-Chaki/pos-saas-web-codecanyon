import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/Provider/payemnt_verification_provider.dart';
import 'package:salespro_saas_admin/Screen/Payment%20Verification/payment_verification_details.dart';
import 'package:salespro_saas_admin/model/payment_verification_model.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class PaymentVerificationScreen extends StatefulWidget {
  const PaymentVerificationScreen({Key? key}) : super(key: key);

  static const String route = '/payment_verification';

  @override
  State<PaymentVerificationScreen> createState() => _PaymentVerificationScreenState();
}

class _PaymentVerificationScreenState extends State<PaymentVerificationScreen> {
  void showDetailsPopUp({required PaymentVerificationModel info}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: PaymentVerificationDetails(
            infoModel: info,
          ),
        );
      },
    );
  }

  void verifyOrCancel({required PaymentVerificationModel paymentVerificationModel, required String status}) async {
    final ref = FirebaseDatabase.instance.ref('Admin Panel').child('Payment Verification').child(paymentVerificationModel.key!);
    await ref.update({'verificationStatus': status});

    final ref2 = FirebaseDatabase.instance.ref(paymentVerificationModel.sellerID).child('Personal Information');
    status == 'verified'
        ? await ref2.update(
            {'smsBalance': paymentVerificationModel.smsSubscriptionPlanModel.numberOfSMS, 'smsValidity': paymentVerificationModel.smsSubscriptionPlanModel.smsValidityInDay})
        : null;
  }

  String selectedOne = 'pending';

  Widget statusButton() {
    return StatefulBuilder(builder: (context, setState1) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              setState1(() {
                setState(() {
                  selectedOne = 'pending';
                });
              });
            },
            child: Container(
              width: 85,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                border: Border.all(width: .5, color: selectedOne != 'pending' ? Colors.grey : kBlueTextColor),
                color: selectedOne == 'pending' ? kBlueTextColor : Colors.white,
              ),
              child: Center(
                  child: Text(
                'Pending',
                style: TextStyle(
                  color: selectedOne == 'pending' ? Colors.white : Colors.black,
                ),
              )),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState1(() {
                setState(() {
                  selectedOne = 'verified';
                });
              });
            },
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                color: selectedOne == 'verified' ? kBlueTextColor : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                border: Border.all(width: .5, color: selectedOne != 'verified' ? Colors.grey : kBlueTextColor),
              ),
              child: Center(
                  child: Text(
                'Verified',
                style: TextStyle(
                  color: selectedOne == 'verified' ? Colors.white : Colors.black,
                ),
              )),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState1(() {
                setState(() {
                  selectedOne = 'cancel';
                });
              });
            },
            child: Container(
              width: 85,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                color: selectedOne == 'cancel' ? kBlueTextColor : Colors.white,
                border: Border.all(width: .5, color: selectedOne != 'cancel' ? Colors.grey : kBlueTextColor),
              ),
              child: Center(
                  child: Text(
                'Canceled',
                style: TextStyle(
                  color: selectedOne == 'cancel' ? Colors.white : Colors.black,
                ),
              )),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      body: Consumer(
        builder: (_, ref, watch) {
          final paymentData = ref.watch(paymentVerificationProvider);

          return paymentData.when(
            data: (data) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: SideBarWidget(
                      index: 9,
                      isTab: false,
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: kWhiteTextColor,
                              ),
                              child: const TopBar(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Payment Verification',
                                          style: kTextStyle.copyWith(color: kTitleColor, fontSize: 22, fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        statusButton(),
                                        const SizedBox(width: 20),
                                        GestureDetector(
                                          onTap: (() => ref.refresh(paymentVerificationProvider)),
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Refresh',
                                                  style: kTextStyle.copyWith(color: kWhiteTextColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    const Divider(
                                      height: 1,
                                      color: Colors.black12,
                                    ),
                                    const SizedBox(height: 10.0),
                                    data.isNotEmpty
                                        ? SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: data.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Container(
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                          border: Border.all(width: 1, color: kLitGreyColor),
                                                          // color: kBlueTextColor.withOpacity(0.05),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(10.0),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text('SMS Package Name : ${data[index].smsSubscriptionPlanModel.smsPackName}'),
                                                                  Text('Payment PhoneNumber : ${data[index].paymentPhoneNumber}'),
                                                                  Text('Paid Amount : ${data[index].paidAmount}'),
                                                                  Text('Transaction Number : ${data[index].transactionId}'),
                                                                ],
                                                              ),
                                                            ),
                                                            const Spacer(),

                                                            ///__________buttons_____________________________
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    ///__________details__________________________________________________
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        showDetailsPopUp(info: data[index]);
                                                                      },
                                                                      child: Container(
                                                                        width: 120,
                                                                        decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                          color: kBlueTextColor,
                                                                        ),
                                                                        padding: const EdgeInsets.all(10),
                                                                        child: const Center(
                                                                          child: Text(
                                                                            'Details',
                                                                            style: TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(width: 20),

                                                                    ///__________Cancel__________________________________________________
                                                                    GestureDetector(
                                                                      onTap: () async {
                                                                        EasyLoading.show(status: 'Loading');
                                                                        verifyOrCancel(paymentVerificationModel: data[index], status: 'cancel');
                                                                        ref.refresh(paymentVerificationProvider);
                                                                        EasyLoading.dismiss();
                                                                      },
                                                                      child: Container(
                                                                        width: 120,
                                                                        decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                          color: Colors.red,
                                                                        ),
                                                                        padding: const EdgeInsets.all(10),
                                                                        child: const Center(
                                                                          child: Text(
                                                                            'Cancel',
                                                                            style: TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ).visible(data[index].verificationStatus == 'pending'),
                                                                    const SizedBox(width: 20).visible(data[index].verificationStatus == 'pending'),

                                                                    ///__________verify__________________________________________________
                                                                    GestureDetector(
                                                                      onTap: () async {
                                                                        EasyLoading.show(status: 'Loading');
                                                                        verifyOrCancel(paymentVerificationModel: data[index], status: 'verified');
                                                                        ref.refresh(paymentVerificationProvider);
                                                                        EasyLoading.dismiss();
                                                                      },
                                                                      child: Container(
                                                                        width: 120,
                                                                        decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                          color: Colors.green,
                                                                        ),
                                                                        padding: const EdgeInsets.all(10),
                                                                        child: const Center(
                                                                          child: Text(
                                                                            'Yes, Verify',
                                                                            style: TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ).visible(data[index].verificationStatus == 'pending'),
                                                                    const SizedBox(width: 20).visible(data[index].verificationStatus == 'pending'),

                                                                    ///_____status______________________________________

                                                                    Container(
                                                                      height: 98,
                                                                      width: 150,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                                                                        color: data[index].verificationStatus == 'cancel' ? Colors.red : Colors.green,
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          data[index].verificationStatus == 'cancel' ? 'Canceled' : 'Verified',
                                                                          style: const TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ).visible(data[index].verificationStatus != 'pending'),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ).visible(data[index].verificationStatus == selectedOne);
                                                  },
                                                )
                                              ],
                                            ),
                                          )
                                        : const Center(
                                            child: Text('No Data Found'),
                                          ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              );
            },
            error: (e, stack) {
              return Center(
                child: Text(e.toString()),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
