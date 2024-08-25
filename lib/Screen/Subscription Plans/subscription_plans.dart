// ignore_for_file: unused_result

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/Provider/subacription_plan_provider.dart';
import 'package:salespro_saas_admin/model/subscription_plan_model.dart';
import '../../currency.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Constant Data/export_button.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class SubscriptionPlans extends StatefulWidget {
  const SubscriptionPlans({Key? key}) : super(key: key);

  static const String route = '/subscription_plans';

  @override
  State<SubscriptionPlans> createState() => _SubscriptionPlansState();
}

class _SubscriptionPlansState extends State<SubscriptionPlans> {
  void newSubscriptionPlanAdd(
      {required WidgetRef ref, required List<String> allNames}) {
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    bool saleUnlimited = false;
    bool purchaseUnlimited = false;
    bool partisUnlimited = false;
    bool dueUnlimited = false;
    bool productUnlimited = false;
    SubscriptionPlanModel subscriptionPlansModel = SubscriptionPlanModel(
      subscriptionName: '',
      saleNumber: 0,
      purchaseNumber: 0,
      partiesNumber: 0,
      dueNumber: 0,
      duration: 0,
      products: 0,
      subscriptionPrice: 0,
      offerPrice: 0,
    );
    TextEditingController saleLimitController = TextEditingController();
    TextEditingController purchaseLimitController = TextEditingController();
    TextEditingController partisLimitController = TextEditingController();
    TextEditingController dueLimitController = TextEditingController();
    TextEditingController productLimitController = TextEditingController();

    bool validateAndSave() {
      final form = globalKey.currentState;
      if (form!.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState1) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: globalKey,
                          child: Column(
                            children: [
                              ///________Name__________________________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'Plan Name',
                                    hintText: 'Enter Plan Name.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'Subscription Plan name is required.';
                                    } else if (allNames.contains(value
                                        ?.toLowerCase()
                                        .removeAllWhiteSpace())) {
                                      return 'Plan name is already added.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    subscriptionPlansModel.subscriptionName =
                                        value!;
                                  },
                                ),
                              ),

                              ///__________Price & Offer Price_______________________________
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmptyOrNull) {
                                            return 'Plan Price is required';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          subscriptionPlansModel
                                                  .subscriptionPrice =
                                              value.toInt();
                                        },
                                        decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Plan Price',
                                          hintText: 'Enter Plan Regular Price.',
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          return null;
                                        },
                                        onSaved: (value) {
                                          subscriptionPlansModel.offerPrice =
                                              value.toInt();
                                        },
                                        decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Offer Price',
                                          hintText: 'Enter Plan Offer Price.',
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ///__________timer duration____________________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'Time Duration in Days',
                                    hintText: 'Enter Time Duration in days.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'Time Duration is required.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    subscriptionPlansModel.duration =
                                        value.toInt();
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),

                              ///__________sale_Limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: saleUnlimited,
                                    controller: saleLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.saleNumber =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Sale Limit',
                                      hintText: 'Enter Sale Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: saleUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        saleUnlimited = value!;
                                                        value
                                                            ? saleLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : saleLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),

                              ///__________Purchase_limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: purchaseUnlimited,
                                    controller: purchaseLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.purchaseNumber =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Purchase Limit',
                                      hintText: 'Enter Purchase Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: purchaseUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        purchaseUnlimited =
                                                            value!;
                                                        value
                                                            ? purchaseLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : purchaseLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),

                              ///__________parties_limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: partisUnlimited,
                                    controller: partisLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.partiesNumber =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Partis Limit',
                                      hintText: 'Enter Partis Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: partisUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        partisUnlimited =
                                                            value!;
                                                        value
                                                            ? partisLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : partisLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),

                              ///__________due_limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: dueUnlimited,
                                    controller: dueLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.dueNumber =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Due Collection Limit',
                                      hintText: 'Enter Due Collection Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: dueUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        dueUnlimited = value!;
                                                        value
                                                            ? dueLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : dueLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),

                              ///__________product_limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: productUnlimited,
                                    controller: productLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.products =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Add Product Limit',
                                      hintText: 'Enter Add Product Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: productUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        productUnlimited =
                                                            value!;
                                                        value
                                                            ? productLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : productLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///_______buttons__________________________________
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (() => Navigator.pop(context)),
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.red),
                                child: Column(
                                  children: [
                                    Text(
                                      'Cancel',
                                      style: kTextStyle.copyWith(
                                          color: kWhiteTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () async {
                                if (validateAndSave()) {
                                  EasyLoading.show(
                                      status: 'Loading...',
                                      dismissOnTap: false);
                                  final DatabaseReference adRef =
                                      FirebaseDatabase.instance
                                          .ref()
                                          .child('Admin Panel')
                                          .child('Subscription Plan');

                                  subscriptionPlansModel.dueNumber == 0
                                      ? subscriptionPlansModel.dueNumber = -202
                                      : null;
                                  subscriptionPlansModel.saleNumber == 0
                                      ? subscriptionPlansModel.saleNumber = -202
                                      : null;
                                  subscriptionPlansModel.products == 0
                                      ? subscriptionPlansModel.products = -202
                                      : null;
                                  subscriptionPlansModel.purchaseNumber == 0
                                      ? subscriptionPlansModel.purchaseNumber =
                                          -202
                                      : null;
                                  subscriptionPlansModel.partiesNumber == 0
                                      ? subscriptionPlansModel.partiesNumber =
                                          -202
                                      : null;
                                  await adRef
                                      .push()
                                      .set(subscriptionPlansModel.toJson());
                                  EasyLoading.showSuccess('Added Successfully',
                                      duration:
                                          const Duration(milliseconds: 500));

                                  ///____provider_refresh____________________________________________
                                  ref.refresh(subscriptionPlanProvider);

                                  Future.delayed(
                                      const Duration(milliseconds: 100), () {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: kBlueTextColor),
                                child: Column(
                                  children: [
                                    Text(
                                      'Save',
                                      style: kTextStyle.copyWith(
                                          color: kWhiteTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
      },
    );
  }

  Future<void> deletePlan(
      {required WidgetRef updateRef, required String name}) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext dialogContext) {
          return Center(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Are you want to delete this advertising?',
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(dialogContext);
                          },
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (!isDemo) {
                              EasyLoading.show(status: 'Deleting..');
                              String imageKey = '';
                              await FirebaseDatabase.instance
                                  .ref()
                                  .child('Admin Panel')
                                  .child('Subscription Plan')
                                  .orderByKey()
                                  .get()
                                  .then((value) async {
                                for (var element in value.children) {
                                  var data =
                                      jsonDecode(jsonEncode(element.value));
                                  if (data['subscriptionName'].toString() ==
                                      name) {
                                    imageKey = element.key.toString();
                                  }
                                }
                              });
                              DatabaseReference ref = FirebaseDatabase.instance
                                  .ref(
                                      "Admin Panel/Subscription Plan/$imageKey");
                              await ref.remove();
                              updateRef.refresh(subscriptionPlanProvider);

                              EasyLoading.showSuccess('Done');
                              // ignore: use_build_context_synchronously
                              Navigator.pop(dialogContext);
                            } else {
                              EasyLoading.showInfo(demoText);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void editSubscriptionPlan(
      {required WidgetRef updateRef,
      required List<String> allNames,
      required SubscriptionPlanModel selectedOne}) {
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    bool saleUnlimited = selectedOne.saleNumber == -202 ? true : false;
    bool purchaseUnlimited = selectedOne.purchaseNumber == -202 ? true : false;
    bool partisUnlimited = selectedOne.partiesNumber == -202 ? true : false;
    bool dueUnlimited = selectedOne.dueNumber == -202 ? true : false;
    bool productUnlimited = selectedOne.products == -202 ? true : false;
    SubscriptionPlanModel subscriptionPlansModel = SubscriptionPlanModel(
      subscriptionName: '',
      saleNumber: 0,
      purchaseNumber: 0,
      partiesNumber: 0,
      dueNumber: 0,
      duration: 0,
      products: 0,
      subscriptionPrice: 0,
      offerPrice: 0,
    );

    TextEditingController saleLimitController = TextEditingController(
        text: selectedOne.saleNumber == -202
            ? 'Unlimited'
            : selectedOne.saleNumber.toString());
    TextEditingController purchaseLimitController = TextEditingController(
        text: selectedOne.purchaseNumber == -202
            ? 'Unlimited'
            : selectedOne.purchaseNumber.toString());
    TextEditingController partisLimitController = TextEditingController(
        text: selectedOne.partiesNumber == -202
            ? 'Unlimited'
            : selectedOne.partiesNumber.toString());
    TextEditingController dueLimitController = TextEditingController(
        text: selectedOne.dueNumber == -202
            ? 'Unlimited'
            : selectedOne.dueNumber.toString());
    TextEditingController productLimitController = TextEditingController(
        text: selectedOne.products == -202
            ? 'Unlimited'
            : selectedOne.products.toString());

    bool validateAndSave() {
      final form = globalKey.currentState;
      if (form!.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState1) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: globalKey,
                          child: Column(
                            children: [
                              ///________Name__________________________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  initialValue: selectedOne.subscriptionName,
                                  readOnly:
                                      selectedOne.subscriptionName == 'Free'
                                          ? true
                                          : false,
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'Plan Name',
                                    hintText: 'Enter Plan Name.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'Subscription Plan name is required.';
                                    } else if (allNames.contains(value
                                            ?.toLowerCase()
                                            .removeAllWhiteSpace()) &&
                                        selectedOne.subscriptionName != value) {
                                      return 'Plan name is already added.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    subscriptionPlansModel.subscriptionName =
                                        value!;
                                  },
                                ),
                              ),

                              ///__________Price & Offer Price_______________________________
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        readOnly:
                                            selectedOne.subscriptionName ==
                                                    'Free'
                                                ? true
                                                : false,
                                        initialValue: selectedOne
                                            .subscriptionPrice
                                            .toString(),
                                        validator: (value) {
                                          if (value.isEmptyOrNull) {
                                            return 'Plan Price is required';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          subscriptionPlansModel
                                                  .subscriptionPrice =
                                              value.toInt();
                                        },
                                        decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Plan Price',
                                          hintText: 'Enter Plan Regular Price.',
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        readOnly:
                                            selectedOne.subscriptionName ==
                                                    'Free'
                                                ? true
                                                : false,
                                        initialValue:
                                            selectedOne.offerPrice.toString(),
                                        validator: (value) {
                                          return null;
                                        },
                                        onSaved: (value) {
                                          subscriptionPlansModel.offerPrice =
                                              value.toInt();
                                        },
                                        decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Offer Price',
                                          hintText: 'Enter Plan Offer Price.',
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ///__________timer duration____________________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  initialValue: selectedOne.duration.toString(),
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'Time Duration in Days',
                                    hintText: 'Enter Time Duration in days.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'Time Duration is required.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    subscriptionPlansModel.duration =
                                        value.toInt();
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),

                              ///__________sale_Limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: saleUnlimited,
                                    controller: saleLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.saleNumber =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Sale Limit',
                                      hintText: 'Enter Sale Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: saleUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        saleUnlimited = value!;
                                                        value
                                                            ? saleLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : saleLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),

                              ///__________Purchase_limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: purchaseUnlimited,
                                    controller: purchaseLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.purchaseNumber =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Purchase Limit',
                                      hintText: 'Enter Purchase Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: purchaseUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        purchaseUnlimited =
                                                            value!;
                                                        value
                                                            ? purchaseLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : purchaseLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),

                              ///__________parties_limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: partisUnlimited,
                                    controller: partisLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.partiesNumber =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Partis Limit',
                                      hintText: 'Enter Partis Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: partisUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        partisUnlimited =
                                                            value!;
                                                        value
                                                            ? partisLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : partisLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),

                              ///__________due_limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: dueUnlimited,
                                    controller: dueLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.dueNumber =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Due Collection Limit',
                                      hintText: 'Enter Due Collection Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: dueUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        dueUnlimited = value!;
                                                        value
                                                            ? dueLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : dueLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),

                              ///__________product_limit_______________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    readOnly: productUnlimited,
                                    controller: productLimitController,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      subscriptionPlansModel.products =
                                          value.toInt();
                                    },
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Add Product Limit',
                                      hintText: 'Enter Add Product Limit.',
                                      border: const OutlineInputBorder(),
                                      suffix: SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text('Unlimited'),
                                                Checkbox(
                                                    value: productUnlimited,
                                                    onChanged: (value) {
                                                      setState1(() {
                                                        productUnlimited =
                                                            value!;
                                                        value
                                                            ? productLimitController
                                                                    .text =
                                                                'Unlimited'
                                                            : productLimitController
                                                                .text = '';
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///_______buttons__________________________________
                        const SizedBox(height: 20),
                        // const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (() => Navigator.pop(context)),
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.red),
                                child: Column(
                                  children: [
                                    Text(
                                      'Cancel',
                                      style: kTextStyle.copyWith(
                                          color: kWhiteTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () async {
                                if (!isDemo) {
                                  if (validateAndSave()) {
                                    subscriptionPlansModel.dueNumber == 0
                                        ? subscriptionPlansModel.dueNumber =
                                            -202
                                        : null;
                                    subscriptionPlansModel.saleNumber == 0
                                        ? subscriptionPlansModel.saleNumber =
                                            -202
                                        : null;
                                    subscriptionPlansModel.products == 0
                                        ? subscriptionPlansModel.products = -202
                                        : null;
                                    subscriptionPlansModel.purchaseNumber == 0
                                        ? subscriptionPlansModel
                                            .purchaseNumber = -202
                                        : null;
                                    subscriptionPlansModel.partiesNumber == 0
                                        ? subscriptionPlansModel.partiesNumber =
                                            -202
                                        : null;

                                    EasyLoading.show(status: 'Editing');
                                    String imageKey = '';
                                    await FirebaseDatabase.instance
                                        .ref()
                                        .child('Admin Panel')
                                        .child('Subscription Plan')
                                        .orderByKey()
                                        .get()
                                        .then((value) async {
                                      for (var element in value.children) {
                                        var data = jsonDecode(
                                            jsonEncode(element.value));
                                        if (data['subscriptionName']
                                                .toString() ==
                                            selectedOne.subscriptionName) {
                                          imageKey = element.key.toString();
                                        }
                                      }
                                    });
                                    DatabaseReference ref =
                                        FirebaseDatabase.instance.ref(
                                            "Admin Panel/Subscription Plan/$imageKey");
                                    await ref.update({
                                      'subscriptionName': subscriptionPlansModel
                                          .subscriptionName,
                                      'subscriptionPrice':
                                          subscriptionPlansModel
                                              .subscriptionPrice,
                                      'saleNumber':
                                          subscriptionPlansModel.saleNumber,
                                      'purchaseNumber':
                                          subscriptionPlansModel.purchaseNumber,
                                      'partiesNumber':
                                          subscriptionPlansModel.partiesNumber,
                                      'dueNumber':
                                          subscriptionPlansModel.dueNumber,
                                      'duration':
                                          subscriptionPlansModel.duration,
                                      'products':
                                          subscriptionPlansModel.partiesNumber,
                                      'offerPrice':
                                          subscriptionPlansModel.offerPrice,
                                    });
                                    EasyLoading.showSuccess(
                                        'Added Successfully!');

                                    ///____provider_refresh____________________________________________
                                    updateRef.refresh(subscriptionPlanProvider);

                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      Navigator.pop(context);
                                    });
                                  }
                                } else {
                                  EasyLoading.showInfo(demoText);
                                }
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: kBlueTextColor),
                                child: Column(
                                  children: [
                                    Text(
                                      'Save',
                                      style: kTextStyle.copyWith(
                                          color: kWhiteTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
      },
    );
  }

  void postFreePlan({required WidgetRef ref}) async {
    SubscriptionPlanModel subscriptionPlansModel = SubscriptionPlanModel(
        subscriptionName: 'Free',
        saleNumber: 50,
        purchaseNumber: 50,
        partiesNumber: 50,
        dueNumber: 50,
        duration: 30,
        products: 50,
        subscriptionPrice: 0,
        offerPrice: 0);
    final DatabaseReference adRef = FirebaseDatabase.instance
        .ref()
        .child('Admin Panel')
        .child('Subscription Plan');
    await adRef.push().set(subscriptionPlansModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(subscriptionPlanProvider);
  }

  int counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUserAndRestartApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: SideBarWidget(
          index: 4,
          isTab: false,
        ),
      ),
      appBar: const GlobalAppbar(),
      backgroundColor: kDarkWhite,
      body: Consumer(
        builder: (_, ref, watch) {
          final reports = ref.watch(subscriptionPlanProvider);
          return reports.when(data: (data) {
            List<String> names = [];
            for (var element in data) {
              names.add(
                  element.subscriptionName.removeAllWhiteSpace().toLowerCase());
            }
            if (data.isNotEmpty) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: kWhiteTextColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Subscription Plans',
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: (() => newSubscriptionPlanAdd(
                                  ref: ref, allNames: names)),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: kBlueTextColor),
                                child: Column(
                                  children: [
                                    Text(
                                      'Add New Subscription Plan',
                                      style: kTextStyle.copyWith(
                                          color: kWhiteTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(
                          height: 1,
                          color: Colors.black12,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * .25,
                              child: TextField(
                                showCursor: true,
                                cursorColor: kTitleColor,
                                decoration: kInputDecoration.copyWith(
                                  hintText: 'Search Anything...',
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: kBlueTextColor,
                                      ),
                                      child: const Icon(FeatherIcons.search,
                                          color: kWhiteTextColor),
                                    ),
                                  ),
                                  hintStyle:
                                      kTextStyle.copyWith(color: kLitGreyColor),
                                  contentPadding: const EdgeInsets.all(4.0),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: kBorderColorTextField, width: 1),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            const ExportButton()
                          ],
                        ).visible(false),
                        const SizedBox(height: 10.0).visible(false),
                        SizedBox(
                          height: 320,
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                            height: 250,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: kGreyTextColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              border: Border.all(
                                                width: 1,
                                                color: kBlueTextColor,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 15),
                                                const Text(
                                                  'Mobile App \n+\nDesktop',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                Text(
                                                  data[index].subscriptionName,
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kGreyTextColor),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  '$currency${data[index].offerPrice > 0 ? data[index].offerPrice : data[index].subscriptionPrice}',
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kGreyTextColor),
                                                ),
                                                Text(
                                                  '$currency${data[index].subscriptionPrice}',
                                                  style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ).visible(
                                                    data[index].offerPrice > 0),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Duration ${data[index].duration} Day',
                                                  style: const TextStyle(
                                                      color: kGreyTextColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                              height: 25,
                                              width: 70,
                                              decoration: const BoxDecoration(
                                                color: kBlueTextColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  data[index].offerPrice ==
                                                          data[index]
                                                              .subscriptionPrice
                                                      ? ""
                                                      : 'Save ${(100 - ((data[index].offerPrice * 100) / data[index].subscriptionPrice)).toInt().toString()}%',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ).visible(data[index].offerPrice > 0),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              editSubscriptionPlan(
                                                  updateRef: ref,
                                                  allNames: names,
                                                  selectedOne: data[index]);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(90)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: kBlueTextColor),
                                                color: kBlueTextColor
                                                    .withOpacity(0.1),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: kBlueTextColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20).visible(
                                              data[index].subscriptionName !=
                                                  'Free'),
                                          GestureDetector(
                                            onTap: () {
                                              deletePlan(
                                                  updateRef: ref,
                                                  name: data[index]
                                                      .subscriptionName);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(90)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.redAccent),
                                                color: Colors.redAccent
                                                    .withOpacity(0.1),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ),
                                          ).visible(
                                              data[index].subscriptionName !=
                                                  'Free'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              counter == 0 ? postFreePlan(ref: ref) : null;
              counter++;
              return Container();
            }
          }, error: (e, stack) {
            return Center(
              child: Text(e.toString()),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
        },
      ),
    );
  }
}
