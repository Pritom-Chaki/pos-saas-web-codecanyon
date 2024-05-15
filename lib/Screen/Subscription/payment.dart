// ignore_for_file: use_build_context_synchronously
import 'dart:html' as htmls;

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salespro_admin/generated/l10n.dart' as lang;

import '../../Provider/bank_info_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../const.dart';
import '../../model/subscription_plan_model.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/TopBar/top_bar_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    this.subscriptionPlanModel,
  });

  final SubscriptionPlanModel? subscriptionPlanModel;

  static const String route = '/pay';

  @override
  // ignore: library_private_types_in_public_api
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ScrollController mainScroll = ScrollController();

  Future<Uint8List?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        imageController.text = result.files.single.name;
      });
      return result.files.single.bytes;
    } else {
      return null;
    }
  }

  Uint8List? bytesFromPicker;
  bool isLoading = false;
  bool isLoadingMonth = false;
  bool isLoadingYear = false;
  bool clickNormal = false;
  bool clickMonth = false;
  bool clickYearly = false;

  Future<String> uploadFile() async {
    try {
      var snapshot = await FirebaseStorage.instance.ref('Subscription Attachment/${DateTime.now().millisecondsSinceEpoch}').putData(bytesFromPicker!);
      var url = await snapshot.ref.getDownloadURL();

      EasyLoading.showSuccess('Upload Successful!');
      return url;
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
      return '';
    }
  }

  SubscriptionRequestModel data = SubscriptionRequestModel(
    subscriptionPlanModel: SubscriptionPlanModel(dueNumber: 0, duration: 0, offerPrice: 0, partiesNumber: 0, products: 0, purchaseNumber: 0, saleNumber: 0, subscriptionName: '', subscriptionPrice: 00),
    transactionNumber: '',
    note: '',
    attachment: '',
    userId: constUserId,
    businessCategory: '',
    companyName: '',
    countryName: '',
    language: '',
    phoneNumber: '',
    pictureUrl: '',
  );
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUserAndRestartApp();
    data.subscriptionPlanModel = widget.subscriptionPlanModel!;
    () async {
      data.userId = await getUserID();
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      body: Consumer(builder: (context, ref, __) {
        final userProfileDetails = ref.watch(profileDetailsProvider);
        final bank = ref.watch(bankInfoProvider);
        return Scrollbar(
          controller: mainScroll,
          child: SingleChildScrollView(
            controller: mainScroll,
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 240,
                  child: SideBarWidget(
                    index: 15,
                    isTab: false,
                  ),
                ),
                userProfileDetails.when(data: (details) {
                  data.countryName = details.countryName;
                  data.language = details.language;
                  data.pictureUrl = details.pictureUrl;
                  data.companyName = details.companyName;
                  data.businessCategory = details.businessCategory;
                  data.phoneNumber = details.phoneNumber ?? '';
                  return Container(
                    width: MediaQuery.of(context).size.width < 1275 ? 1275 - 240 : MediaQuery.of(context).size.width - 240, // width: context.width() < 1080 ? 1080 - 240 : MediaQuery.of(context).size.width - 240,
                    decoration: const BoxDecoration(color: kDarkWhite),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //_______________________________top_bar____________________________
                          const TopBar(),

                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: kWhiteTextColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lang.S.of(context).buy,
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: kGreyTextColor.withOpacity(0.1),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "পিক্স পজের সাবস্ক্রিপশন বিকাশ অথবা নগদের মাধ্যমে পেমেন্ট করতে পারেন।",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: 'পঅটোমেটিক মাসিক পেমেন্ট করতে ',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(text: 'PAY MONTHLY WITH BKASH', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue)),
                                              TextSpan(text: ' বাটন প্রেস করে উক্ত ফরমে আপনার শপের ইমেইল ও নামের জায়গায় শপের নাম দিয়ে পেমেন্ট করতে পারবেন।'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: 'এক বছরের প্ল্যান ক্রয় করতে ',
                                            style: const TextStyle(
                                              fontSize: 17,
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(text: 'PAY YEARLY WITH BKASH', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                                              TextSpan(text: ' বাটনে ক্লিক করে উক্ত ফরমে আপনার শপের ইমেইল ও নামের জায়গায় শপের নাম দিয়ে পেমেন্ট করতে পারবেন।'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "এ ছাড়াও নিচের মোবাইল নাম্বারে বিকাশ অথবা নগদে সেন্ড মানি করতে পারবেন",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "bKash or Nagad Personal SEND MONEY - 01918005851",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text:
                                                'সেন্ড মানি করে নিচের ফরমে ট্রানজেশন নাম্বার,  যে নাম্বার থেকে টাকা পাঠিয়েছেন সেই নাম্বার ও স্কিন শট আপলোড করে দিবেন।  কোন প্রকার সমস্যা হলে আমাদের সাপোর্ট নাম্বারে যোগাযোগ করবেন ',
                                            style: const TextStyle(
                                              fontSize: 17,
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(text: '01962703099', style: TextStyle(fontWeight: FontWeight.bold)),
                                              TextSpan(text: ' (সকাল ১০ টা থেকে সন্ধা ৭ টা)'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            data.transactionNumber = value;
                                          },
                                          decoration: kInputDecoration.copyWith(
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              labelText: lang.S.of(context).transactionId,
                                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                              labelStyle: kTextStyle.copyWith(fontWeight: FontWeight.bold, color: kTitleColor),
                                              hintText: lang.S.of(context).enterTransactionId),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            data.note = value;
                                          },
                                          decoration: kInputDecoration.copyWith(
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                              labelText: lang.S.of(context).note,
                                              labelStyle: kTextStyle.copyWith(fontWeight: FontWeight.bold, color: kTitleColor),
                                              hintText: lang.S.of(context).enterNote),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          controller: imageController,
                                          onTap: () async {
                                            bytesFromPicker = await pickFile();
                                          },
                                          readOnly: true,
                                          decoration: kInputDecoration.copyWith(
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              labelText: lang.S.of(context).uploadDocument,
                                              labelStyle: kTextStyle.copyWith(fontWeight: FontWeight.bold, color: kTitleColor),
                                              hintText: lang.S.of(context).uploadFile,
                                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                              suffixIcon: const Icon(
                                                FeatherIcons.upload,
                                                color: kGreyTextColor,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                              backgroundColor: kMainColor,
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (data.transactionNumber == '') {
                                                EasyLoading.showError('Please Enter Transaction Number');
                                              } else {
                                                setState(() {
                                                  isLoading = true;
                                                  clickYearly = false;
                                                  clickMonth = false;
                                                  clickNormal = true;
                                                });

                                                String? sellerUserRef = await getSaleID(id: await getUserID());
                                                if (sellerUserRef != null) {
                                                  data.userId = await getUserID();
                                                  EasyLoading.show(status: 'Loading...');
                                                  data.attachment = await uploadFile();
                                                  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('Admin Panel').child('Subscription Update Request');
                                                  await ref.push().set(data.toJson());
                                                  EasyLoading.showSuccess('Request has been send');
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                } else {
                                                  EasyLoading.showError('You Are Not A Valid User');
                                                }
                                                setState(() {
                                                  isLoading = false;
                                                  clickYearly = false;
                                                  clickMonth = false;
                                                  clickNormal = false;
                                                });
                                              }
                                            },
                                            child: isLoading
                                                ? const CircularProgressIndicator()
                                                : Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Text(
                                                      "UPLOAD NOW",
                                                      style: kTextStyle.copyWith(color: kWhiteTextColor, fontSize: 18.0),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                              backgroundColor: Colors.orange,
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            onPressed: (clickNormal || clickMonth)
                                                ? null
                                                : () async {
                                                    setState(() {
                                                      isLoadingYear = true;
                                                      clickYearly = true;
                                                      clickMonth = false;
                                                      clickNormal = false;
                                                    });

                                                    EasyLoading.show(status: 'Loading...');
                                                    String yearlyUrl = "https://shop.bkash.com/pix-store01752156079/pay/bdt2999/rD0hia";
                                                    await htmls.window.open(yearlyUrl, '_blank');
                                                    EasyLoading.dismiss();
                                                    String? sellerUserRef = await getSaleID(id: await getUserID());
                                                    if (sellerUserRef != null) {
                                                      data.userId = await getUserID();
                                                      data.transactionNumber = 'yearly-bdt2999-' + data.phoneNumber;
                                                      EasyLoading.show(status: 'Loading...');
                                                      data.attachment = await uploadFile();
                                                      final DatabaseReference ref = FirebaseDatabase.instance.ref().child('Admin Panel').child('Subscription Update Request');
                                                      await ref.push().set(data.toJson());
                                                      EasyLoading.showSuccess('Request has been send');
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    } else {
                                                      EasyLoading.showError('You Are Not A Valid User');
                                                    }

                                                    setState(() {
                                                      isLoadingYear = false;
                                                      clickYearly = false;
                                                      clickMonth = false;
                                                      clickNormal = false;
                                                    });
                                                  },
                                            child: isLoadingMonth
                                                ? const CircularProgressIndicator()
                                                : Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Text(
                                                      "PAY YEARLY WITH BKASH",
                                                      style: kTextStyle.copyWith(color: Colors.white, fontSize: 18.0),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                              backgroundColor: Colors.blueAccent,
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            onPressed: (clickNormal || clickYearly)
                                                ? null
                                                : () async {
                                                    EasyLoading.show(status: 'Loading...');
                                                    setState(() {
                                                      clickYearly = false;
                                                      isLoadingMonth = true;
                                                      clickMonth = true;
                                                      clickNormal = false;
                                                    });
                                                    String monthUrl = "https://shop.bkash.com/pix-store01752156079/pay/bdt349/kl70VR";

                                                    try {
                                                      // await htmls.window.open(monthUrl, '_self');
                                                      await htmls.window.open(monthUrl, '_blank');
                                                      EasyLoading.dismiss();
                                                      String? sellerUserRef = await getSaleID(id: await getUserID());
                                                      if (sellerUserRef != null) {
                                                        data.userId = await getUserID();
                                                        data.transactionNumber = 'month-bdt349-' + data.phoneNumber;
                                                        EasyLoading.show(status: 'Loading...');
                                                        data.attachment = await uploadFile();
                                                        final DatabaseReference ref = FirebaseDatabase.instance.ref().child('Admin Panel').child('Subscription Update Request');
                                                        await ref.push().set(data.toJson());
                                                        EasyLoading.showSuccess('Request has been send');
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      } else {
                                                        EasyLoading.showError('You Are Not A Valid User');
                                                      }
                                                    } catch (e) {
                                                      EasyLoading.dismiss();
                                                      EasyLoading.showError('Could not launch, please try later.');
                                                    }

                                                    setState(() {
                                                      isLoadingMonth = false;
                                                      clickYearly = false;
                                                      clickMonth = false;
                                                      clickNormal = false;
                                                    });
                                                  },
                                            child: isLoadingMonth
                                                ? const CircularProgressIndicator()
                                                : Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Text(
                                                      "PAY MONTHLY WITH BKASH",
                                                      style: kTextStyle.copyWith(color: Colors.white, fontSize: 18.0),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }, error: (Object error, StackTrace? stackTrace) {
                  return Text(error.toString());
                }, loading: () {
                  return const Center(child: CircularProgressIndicator());
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class SubscriptionRequestModel {
  SubscriptionPlanModel subscriptionPlanModel;
  late String transactionNumber, note, attachment, userId;
  String phoneNumber;
  String companyName;
  String pictureUrl;
  String businessCategory;
  String language;
  String countryName;

  SubscriptionRequestModel({
    required this.subscriptionPlanModel,
    required this.transactionNumber,
    required this.note,
    required this.attachment,
    required this.userId,
    required this.phoneNumber,
    required this.businessCategory,
    required this.companyName,
    required this.pictureUrl,
    required this.countryName,
    required this.language,
  });

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'id': DateTime.now().toString(),
        'userId': userId,
        'subscriptionName': subscriptionPlanModel.subscriptionName,
        'subscriptionDuration': subscriptionPlanModel.duration,
        'subscriptionPrice': subscriptionPlanModel.offerPrice > 0 ? subscriptionPlanModel.offerPrice : subscriptionPlanModel.subscriptionPrice,
        'transactionNumber': transactionNumber,
        'note': note,
        'status': 'pending',
        'approvedDate': '',
        'attachment': attachment,
        'phoneNumber': phoneNumber,
        'companyName': companyName,
        'pictureUrl': pictureUrl,
        'businessCategory': businessCategory,
        'language': language,
        'countryName': countryName,
      };
}
