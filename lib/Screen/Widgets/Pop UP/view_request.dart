// ignore_for_file: unused_result

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salespro_saas_admin/Provider/seller_info_provider.dart';
import 'package:salespro_saas_admin/Screen/Widgets/Constant%20Data/constant.dart';

import '../../../Provider/get_subscription_request_privider.dart';
import '../../../model/subscription_model.dart';
import '../../../model/subscription_request_model.dart';

class ViewRequest extends StatefulWidget {
  const ViewRequest({Key? key, required this.infoModel, required this.ref}) : super(key: key);

  final SubscriptionRequestModel infoModel;
  final WidgetRef ref;

  @override
  State<ViewRequest> createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'VIEW SHOP',
                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (() => Navigator.pop(context)),
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          color: kRedTextColor.withOpacity(0.1),
                        ),
                      ),
                      child: const Icon(FeatherIcons.x, size: 18.0, color: kRedTextColor),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1.0, color: kBorderColorTextField),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Logo',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(widget.infoModel.pictureUrl ?? ''),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Shop Name',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.infoModel.companyName ?? '',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Business Category',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.infoModel.businessCategory ?? '',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Phone Number',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.infoModel.phoneNumber ?? '',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Package',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.infoModel.subscriptionName,
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Package Duration',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${widget.infoModel.duration} Days',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Transaction Number',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.infoModel.transactionNumber,
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Amount',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.infoModel.amount.toString(),
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Status',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.infoModel.status,
                          style: kTextStyle.copyWith(
                              color: widget.infoModel.status == 'pending'
                                  ? Colors.orange
                                  : widget.infoModel.status == 'approved'
                                      ? Colors.green
                                      : Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Date',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.infoModel.id.substring(0, 10),
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              ///__________Attchment_______________
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Attachment',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ':',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(width: 10),
                        widget.infoModel.attachment == ''
                            ? Text(
                                'No File',
                                style: kTextStyle.copyWith(color: kGreyTextColor),
                              )
                            : SizedBox(
                                height: 200,
                                width: 300,
                                child: Image.network(
                                  widget.infoModel.attachment,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),

              ///________Buttons___________________________________________________-

              Visibility(
                visible: widget.infoModel.status == 'pending',
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            EasyLoading.show(status: 'Loading...');
                            String imageKey = '';
                            await FirebaseDatabase.instance.ref().child('Admin Panel').child('Subscription Update Request').orderByKey().get().then((value) async {
                              for (var element in value.children) {
                                var data = jsonDecode(jsonEncode(element.value));
                                if (data['subscriptionName'].toString() == widget.infoModel.subscriptionName) {
                                  imageKey = element.key.toString();
                                }
                              }
                            });
                            DatabaseReference ref = FirebaseDatabase.instance.ref("Admin Panel/Subscription Update Request/$imageKey");
                            await ref.remove();

                            ///____provider_refresh____________________________________________
                            widget.ref.refresh(subscriptionRequestProvider);
                            EasyLoading.showSuccess('Done');

                            Future.delayed(const Duration(milliseconds: 100), () {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 90,
                            decoration: const BoxDecoration(color: Colors.orange),
                            child: Text(
                              'Delete',
                              style: kTextStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            EasyLoading.show(status: 'Loading...');
                            String imageKey = '';
                            await FirebaseDatabase.instance.ref().child('Admin Panel').child('Subscription Update Request').orderByKey().get().then((value) async {
                              for (var element in value.children) {
                                var data = jsonDecode(jsonEncode(element.value));
                                if (data['subscriptionName'].toString() == widget.infoModel.subscriptionName) {
                                  imageKey = element.key.toString();
                                }
                              }
                            });
                            DatabaseReference ref = FirebaseDatabase.instance.ref("Admin Panel/Subscription Update Request/$imageKey");
                            await ref.update({
                              'status': "rejected",
                            });

                            ///____provider_refresh____________________________________________
                            widget.ref.refresh(subscriptionRequestProvider);
                            EasyLoading.showSuccess('Done');

                            Future.delayed(const Duration(milliseconds: 100), () {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 90,
                            decoration: const BoxDecoration(color: Colors.red),
                            child: Text(
                              'Reject',
                              style: kTextStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            SubscriptionModel selectedSubscription = SubscriptionModel(
                              subscriptionName: '',
                              subscriptionDate: DateTime.now().toString(),
                              saleNumber: 0,
                              purchaseNumber: 0,
                              partiesNumber: 0,
                              dueNumber: 0,
                              duration: 0,
                              products: 0,
                            );

                            EasyLoading.show(status: 'Loading...');
                            String imageKey = '';
                            await FirebaseDatabase.instance.ref().child('Admin Panel').child('Subscription Update Request').orderByKey().get().then((value) async {
                              for (var element in value.children) {
                                var data = jsonDecode(jsonEncode(element.value));
                                if (data['id'].toString() == widget.infoModel.id) {
                                  imageKey = element.key.toString();
                                }
                              }
                            });
                            await FirebaseDatabase.instance.ref().child('Admin Panel').child('Subscription Plan').orderByKey().get().then((value) async {
                              for (var element in value.children) {
                                var data = jsonDecode(jsonEncode(element.value));
                                if (data['subscriptionName'].toString() == widget.infoModel.subscriptionName) {
                                  selectedSubscription = SubscriptionModel(
                                    subscriptionName: data['subscriptionName'],
                                    subscriptionDate: DateTime.now().toString(),
                                    saleNumber: data['saleNumber'],
                                    purchaseNumber: data['purchaseNumber'],
                                    partiesNumber: data['partiesNumber'],
                                    dueNumber: data['dueNumber'],
                                    duration: data['duration'],
                                    products: data['products'],
                                  );
                                }
                              }
                            });
                            final DatabaseReference subscriptionRef = FirebaseDatabase.instance.ref().child(widget.infoModel.userId).child('Subscription');

                            await subscriptionRef.set(selectedSubscription.toJson());

                            DatabaseReference ref = FirebaseDatabase.instance.ref("Admin Panel/Subscription Update Request/$imageKey");
                            await ref.update({
                              'status': "approved",
                              'approvedDate': DateTime.now().toString(),
                            });

                            ///_____Seller_info_update________________________________________
                            final DatabaseReference superAdminSellerListRepo =
                                FirebaseDatabase.instance.ref().child('Admin Panel').child('Seller List').child(await getSaleID(id: widget.infoModel.userId));
                            superAdminSellerListRepo.update({
                              "subscriptionDate": DateTime.now().toString(),
                              "subscriptionName": selectedSubscription.subscriptionName,
                            });

                            ///____provider_refresh____________________________________________
                            widget.ref.refresh(subscriptionRequestProvider);
                            widget.ref.refresh(sellerInfoProvider);

                            EasyLoading.showSuccess('Done');

                            Future.delayed(const Duration(milliseconds: 100), () {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 90,
                            decoration: const BoxDecoration(color: Colors.green),
                            child: Text(
                              'Accept',
                              style: kTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
