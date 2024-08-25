import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/model/sms_subscription_plan_model.dart';
import '../../Provider/sms_package_provider.dart';
import '../../currency.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Constant Data/export_button.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class SMSPackage extends StatefulWidget {
  const SMSPackage({Key? key}) : super(key: key);

  static const String route = '/sms_package';

  @override
  State<SMSPackage> createState() => _SMSPackageState();
}

class _SMSPackageState extends State<SMSPackage> {
  void newSubscriptionPlanAdd({required WidgetRef ref, required List<String> allNames}) {
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    SmsSubscriptionPlanModel smsSubscriptionPlanModel = SmsSubscriptionPlanModel(
      smsPackName: '',
      smsPackPrice: 0,
      smsPackOfferPrice: 0,
      numberOfSMS: 0,
      smsValidityInDay: 0,
    );

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
        double temp = 0;
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
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'Package Name',
                                    hintText: 'Enter Package Name.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'Sms Package name is required.';
                                    } else if (allNames.contains(value?.toLowerCase().removeAllWhiteSpace())) {
                                      return 'Sms Package name is already added.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    smsSubscriptionPlanModel.smsPackName = value!;
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
                                            return 'Package Price is required';
                                          } else if (int.parse(value!) <= 0) {
                                            return 'Package Price is not valid';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          temp = value.toDouble();
                                        },
                                        onSaved: (value) {
                                          smsSubscriptionPlanModel.smsPackPrice = value.toDouble();
                                        },
                                        decoration: const InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          labelText: 'Package Price',
                                          hintText: 'Enter Package Regular Price.',
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmptyOrNull) {
                                            return null;
                                          } else if (double.parse(value!) >= temp) {
                                            return 'Offer price can not be bigger then Regular price';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          smsSubscriptionPlanModel.smsPackOfferPrice = value.toDouble().abs();
                                        },
                                        decoration: const InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          labelText: 'Offer Price',
                                          hintText: 'Enter Package Offer Price.',
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
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
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'Sms Validity in Days',
                                    hintText: 'Enter validity in days.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'validity is required.';
                                    } else if (int.parse(value!) <= 0) {
                                      return 'Sms Validity is not valid';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    smsSubscriptionPlanModel.smsValidityInDay = value.toInt();
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),

                              ///__________timer duration____________________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'Number Of Sms',
                                    hintText: 'Enter number of sms.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'Enter number of sms is required.';
                                    } else if (int.parse(value!) <= 0) {
                                      return 'number of sms is not valid';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    smsSubscriptionPlanModel.numberOfSMS = value.toInt();
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
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
                                if (validateAndSave()) {
                                  EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                  final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Sms Package Plan');

                                  smsSubscriptionPlanModel.numberOfSMS == 0 ? smsSubscriptionPlanModel.numberOfSMS = -202 : null;
                                  await adRef.push().set(smsSubscriptionPlanModel.toJson());
                                  EasyLoading.showSuccess('Added Successfully', duration: const Duration(milliseconds: 500));

                                  ///____provider_refresh____________________________________________
                                  ref.refresh(smsPackageProvider);

                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    Navigator.pop(context);
                                  });
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
                      ],
                    ),
                  ),
                ),
              ));
        });
      },
    );
  }

  Future<void> deletePlan({required WidgetRef updateRef, required String name}) async {
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
                      'Are you want to delete this package?',
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
                            EasyLoading.show(status: 'Deleting..');
                            String imageKey = '';
                            await FirebaseDatabase.instance.ref().child('Admin Panel').child('Sms Package Plan').orderByKey().get().then((value) async {
                              for (var element in value.children) {
                                var data = jsonDecode(jsonEncode(element.value));
                                if (data['smsPackName'].toString() == name) {
                                  imageKey = element.key.toString();
                                }
                              }
                            });
                            DatabaseReference ref = FirebaseDatabase.instance.ref("Admin Panel/Sms Package Plan/$imageKey");
                            await ref.remove();
                            updateRef.refresh(smsPackageProvider);

                            EasyLoading.showSuccess('Done');
                            // ignore: use_build_context_synchronously
                            Navigator.pop(dialogContext);
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

  void editSubscriptionPlan({required WidgetRef updateRef, required List<String> allNames, required SmsSubscriptionPlanModel selectedOne}) {
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    SmsSubscriptionPlanModel smsSubscriptionPlanModel = SmsSubscriptionPlanModel(
      smsPackName: '',
      smsPackPrice: 0,
      smsPackOfferPrice: 0,
      numberOfSMS: 0,
      smsValidityInDay: 0,
    );

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
                                  initialValue: selectedOne.smsPackName,
                                  readOnly: selectedOne.smsPackName == 'Basic' ? true : false,
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'Package Name',
                                    hintText: 'Enter Package Name.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'SMS Package name is required.';
                                    } else if (allNames.contains(value?.toLowerCase().removeAllWhiteSpace()) && selectedOne.smsPackName != value) {
                                      return 'Package name is already added.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    smsSubscriptionPlanModel.smsPackName = value!;
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
                                        initialValue: selectedOne.smsPackPrice.toString(),
                                        validator: (value) {
                                          if (value.isEmptyOrNull) {
                                            return 'Plan Price is required';
                                          } else if (int.parse(value!) <= 0) {
                                            return 'Plan Price is not valid';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          smsSubscriptionPlanModel.smsPackPrice = value.toDouble().abs();
                                        },
                                        decoration: const InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          labelText: 'Package Price',
                                          hintText: 'Enter Package Regular Price.',
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        initialValue: selectedOne.smsPackOfferPrice.toString(),
                                        validator: (value) {
                                          return null;
                                        },
                                        onSaved: (value) {
                                          smsSubscriptionPlanModel.smsPackOfferPrice = value.toDouble().abs();
                                        },
                                        decoration: const InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          labelText: 'Offer Price',
                                          hintText: 'Enter Package Offer Price.',
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
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
                                  initialValue: selectedOne.smsValidityInDay.toString(),
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'SMS Validity in Days',
                                    hintText: 'Enter SMS Validity in days.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'SMS Validity is required.';
                                    } else if (int.parse(value!) <= 0) {
                                      return 'SMS Validity is not valid';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    smsSubscriptionPlanModel.smsValidityInDay = value.toInt().abs();
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),

                              ///__________Number Of Sms____________________________________
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  initialValue: selectedOne.smsValidityInDay.toString(),
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    labelText: 'Number Of SMS',
                                    hintText: 'Enter Number Of SMS.',
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'Number Of SMS is required.';
                                    } else if (int.parse(value!) <= 0) {
                                      return 'Number Of SMS is not valid';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    smsSubscriptionPlanModel.numberOfSMS = value.toInt().abs();
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
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
                                if (validateAndSave()) {
                                  EasyLoading.show(status: 'Editing');
                                  String imageKey = '';
                                  await FirebaseDatabase.instance.ref().child('Admin Panel').child('Sms Package Plan').orderByKey().get().then((value) async {
                                    for (var element in value.children) {
                                      var data = jsonDecode(jsonEncode(element.value));
                                      if (data['smsPackName'].toString() == selectedOne.smsPackName) {
                                        imageKey = element.key.toString();
                                      }
                                    }
                                  });
                                  DatabaseReference ref = FirebaseDatabase.instance.ref("Admin Panel/Sms Package Plan/$imageKey");
                                  await ref.update({
                                    'smsPackName': smsSubscriptionPlanModel.smsPackName,
                                    'smsPackPrice': smsSubscriptionPlanModel.smsPackPrice,
                                    'smsPackOfferPrice': smsSubscriptionPlanModel.smsPackOfferPrice,
                                    'numberOfSMS': smsSubscriptionPlanModel.numberOfSMS,
                                    'smsValidityInDay': smsSubscriptionPlanModel.smsValidityInDay,
                                  });
                                  EasyLoading.showSuccess('Added Successfully!');

                                  ///____provider_refresh____________________________________________
                                  updateRef.refresh(smsPackageProvider);

                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    Navigator.pop(context);
                                  });
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
                      ],
                    ),
                  ),
                ),
              ));
        });
      },
    );
  }

  void postBasicPlan({required WidgetRef ref}) async {
    SmsSubscriptionPlanModel smsSubscriptionPlanModel = SmsSubscriptionPlanModel(
      smsPackName: 'Basic',
      smsPackPrice: 50,
      smsPackOfferPrice: 40,
      numberOfSMS: 500,
      smsValidityInDay: 30,
    );
    final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Sms Package Plan');
    await adRef.push().set(smsSubscriptionPlanModel.toJson());

    ///____provider_refresh____________________________________________
    ref.refresh(smsPackageProvider);
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      body: Consumer(
        builder: (_, ref, watch) {
          final reports = ref.watch(smsPackageProvider);
          return reports.when(data: (data) {
            List<String> names = [];
            for (var element in data) {
              names.add(element.smsPackName.removeAllWhiteSpace().toLowerCase());
            }
            if (data.isNotEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: SideBarWidget(
                      index: 5,
                      isTab: false,
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: SingleChildScrollView(
                        child: Column(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'SMS Package Plans',
                                          style: kTextStyle.copyWith(color: kTitleColor, fontSize: 22, fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: (() => newSubscriptionPlanAdd(ref: ref, allNames: names)),
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Add New SMS Package',
                                                  style: kTextStyle.copyWith(color: kWhiteTextColor),
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
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    color: kBlueTextColor,
                                                  ),
                                                  child: const Icon(FeatherIcons.search, color: kWhiteTextColor),
                                                ),
                                              ),
                                              hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                                              contentPadding: const EdgeInsets.all(4.0),
                                              enabledBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0),
                                                ),
                                                borderSide: BorderSide(color: kBorderColorTextField, width: 1),
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
                                                          color: kGreenTextColor.withOpacity(0.1),
                                                          borderRadius: const BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          border: Border.all(
                                                            width: 1,
                                                            color: kGreenTextColor,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            const SizedBox(height: 5),
                                                            Text(
                                                              data[index].smsPackName,
                                                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kGreenTextColor),
                                                            ),
                                                            const SizedBox(height: 5),
                                                            Text(
                                                              '$currency${data[index].smsPackOfferPrice > 0 ? data[index].smsPackOfferPrice : data[index].smsPackPrice}',
                                                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kGreenTextColor),
                                                            ),
                                                            Text(
                                                              '$currency${data[index].smsPackPrice}',
                                                              style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 14, color: Colors.grey),
                                                            ).visible(data[index].smsPackOfferPrice > 0),
                                                            const SizedBox(height: 15),
                                                            Text(
                                                              'Number Of SMS: ${data[index].numberOfSMS}',
                                                              textAlign: TextAlign.center,
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            const SizedBox(height: 5),
                                                            Text(
                                                              'Validity ${data[index].smsValidityInDay} Day',
                                                              style: const TextStyle(color: kGreyTextColor),
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
                                                            color: kGreenTextColor,
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              bottomRight: Radius.circular(10),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              data[index].smsPackOfferPrice == data[index].smsPackPrice
                                                                  ? ""
                                                                  : 'Save ${(100 - ((data[index].smsPackOfferPrice * 100) / data[index].smsPackPrice)).toInt().toString()}%',
                                                              style: const TextStyle(color: Colors.white),
                                                            ),
                                                          ),
                                                        ),
                                                      ).visible(data[index].smsPackOfferPrice > 0),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          editSubscriptionPlan(updateRef: ref, allNames: names, selectedOne: data[index]);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.all(Radius.circular(90)),
                                                            border: Border.all(width: 1, color: kGreenTextColor),
                                                            color: kGreenTextColor.withOpacity(0.1),
                                                          ),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.edit,
                                                              color: kGreenTextColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 20).visible(data[index].smsPackName != 'Free'),
                                                      GestureDetector(
                                                        onTap: () {
                                                          deletePlan(updateRef: ref, name: data[index].smsPackName);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.all(Radius.circular(90)),
                                                            border: Border.all(width: 1, color: Colors.redAccent),
                                                            color: Colors.redAccent.withOpacity(0.1),
                                                          ),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.delete_forever,
                                                              color: Colors.redAccent,
                                                            ),
                                                          ),
                                                        ),
                                                      ).visible(data[index].smsPackName != 'Basic'),
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
                          ],
                        ),
                      ))
                ],
              );
            } else {
              counter == 0 ? postBasicPlan(ref: ref) : null;
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
