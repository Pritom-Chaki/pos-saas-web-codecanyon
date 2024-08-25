import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/model/nid_verification_model.dart';
import '../../Provider/nid_varification_provider.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Pop Up/Reports/view_reports.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class NIDVerificationScreen extends StatefulWidget {
  const NIDVerificationScreen({Key? key}) : super(key: key);

  static const String route = '/nid_verification';

  @override
  State<NIDVerificationScreen> createState() => _NIDVerificationScreenState();
}

class _NIDVerificationScreenState extends State<NIDVerificationScreen> {
  void verifyOrCancel({required NIDVerificationModel nidVerificationModel, required String status}) async {
    final ref = FirebaseDatabase.instance.ref('Admin Panel').child('NID Verification').child(nidVerificationModel.key!);
    await ref.update({'verificationStatus': 'verified'});

    final ref2 = FirebaseDatabase.instance.ref(nidVerificationModel.sellerID).child('Personal Information');
    await ref2.update({'verificationStatus': 'verified'});
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
              width: 70,
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
          final nid = ref.watch(nidVerificationProvider);

          return nid.when(
            data: (data) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: SideBarWidget(
                      index: 8,
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
                                          'NID Verification',
                                          style: kTextStyle.copyWith(color: kTitleColor, fontSize: 22, fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        statusButton(),
                                        const SizedBox(width: 20),
                                        GestureDetector(
                                          onTap: (() => ref.refresh(nidVerificationProvider)),
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
                                        )
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
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                              border: Border.all(width: 1, color: kLitGreyColor),
                                                              // color: kBlueTextColor.withOpacity(0.05),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(10.0),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    height: 130,
                                                                    width: 220,
                                                                    decoration: BoxDecoration(border: Border.all(width: 1, color: kLitGreyColor)),
                                                                    child: Image(
                                                                      image: NetworkImage(data[index].nidFrontPart),
                                                                      fit: BoxFit.fill,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 10),
                                                                  Container(
                                                                    height: 130,
                                                                    width: 220,
                                                                    decoration: BoxDecoration(border: Border.all(width: 1, color: kLitGreyColor)),
                                                                    child: Image(
                                                                      image: NetworkImage(data[index].nidBackPart),
                                                                      fit: BoxFit.fill,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 20),
                                                                  SizedBox(
                                                                    height: 160,
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              width: 100,
                                                                              height: 30,
                                                                              alignment: Alignment.centerLeft,
                                                                              decoration: const BoxDecoration(
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(15),
                                                                                  bottomLeft: Radius.circular(15),
                                                                                ),
                                                                                color: Colors.grey,
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: const Text(
                                                                                'Seller Name',
                                                                                style: TextStyle(color: kDarkGreyColor),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: 220,
                                                                              height: 30,
                                                                              alignment: Alignment.centerLeft,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: const BorderRadius.only(
                                                                                  topRight: Radius.circular(15),
                                                                                  bottomRight: Radius.circular(15),
                                                                                ),
                                                                                color: Colors.grey.withOpacity(0.2),
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                data[index].sellerName,
                                                                                style: const TextStyle(color: kDarkGreyColor),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              height: 30,
                                                                              width: 100,
                                                                              alignment: Alignment.centerLeft,
                                                                              decoration: const BoxDecoration(
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(15),
                                                                                  bottomLeft: Radius.circular(15),
                                                                                ),
                                                                                color: Colors.grey,
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: const Text(
                                                                                'Shop Name',
                                                                                style: TextStyle(color: kDarkGreyColor),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: 30,
                                                                              width: 220,
                                                                              alignment: Alignment.centerLeft,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: const BorderRadius.only(
                                                                                  topRight: Radius.circular(15),
                                                                                  bottomRight: Radius.circular(15),
                                                                                ),
                                                                                color: Colors.grey.withOpacity(0.2),
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                data[index].shopName,
                                                                                style: const TextStyle(color: kDarkGreyColor),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              height: 30,
                                                                              width: 100,
                                                                              alignment: Alignment.centerLeft,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: const BorderRadius.only(
                                                                                  topLeft: Radius.circular(15),
                                                                                  bottomLeft: Radius.circular(15),
                                                                                ),
                                                                                color: Colors.grey.withOpacity(0.8),
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: const Text(
                                                                                'Seller Phone',
                                                                                style: TextStyle(color: kDarkGreyColor),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: 30,
                                                                              width: 220,
                                                                              alignment: Alignment.centerLeft,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: const BorderRadius.only(
                                                                                  topRight: Radius.circular(15),
                                                                                  bottomRight: Radius.circular(15),
                                                                                ),
                                                                                color: Colors.grey.withOpacity(0.2),
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                data[index].sellerPhone,
                                                                                style: const TextStyle(color: kDarkGreyColor),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              height: 30,
                                                                              width: 100,
                                                                              alignment: Alignment.centerLeft,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: const BorderRadius.only(
                                                                                  topLeft: Radius.circular(15),
                                                                                  bottomLeft: Radius.circular(15),
                                                                                ),
                                                                                color: Colors.grey.withOpacity(0.8),
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: const Text(
                                                                                'Date',
                                                                                style: TextStyle(color: kDarkGreyColor),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: 30,
                                                                              width: 220,
                                                                              alignment: Alignment.centerLeft,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: const BorderRadius.only(
                                                                                  topRight: Radius.circular(15),
                                                                                  bottomRight: Radius.circular(15),
                                                                                ),
                                                                                color: Colors.grey.withOpacity(0.2),
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                data[index].verificationAttemptsDate.substring(0, 10),
                                                                                style: const TextStyle(color: kDarkGreyColor),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Spacer(),

                                                                  ///__________buttons_____________________________
                                                                  SizedBox(
                                                                    height: 160,
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                EasyLoading.show(status: 'Loading');
                                                                                verifyOrCancel(nidVerificationModel: data[index], status: 'cancel');
                                                                                ref.refresh(nidVerificationProvider);
                                                                                EasyLoading.dismiss();
                                                                              },
                                                                              child: Container(
                                                                                width: 120,
                                                                                decoration: const BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                                  color: Colors.red,
                                                                                ),
                                                                                padding: const EdgeInsets.all(15),
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    'Cancel',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 20),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                EasyLoading.show(status: 'Loading');
                                                                                verifyOrCancel(nidVerificationModel: data[index], status: 'verified');
                                                                                ref.refresh(nidVerificationProvider);
                                                                                EasyLoading.dismiss();
                                                                              },
                                                                              child: Container(
                                                                                width: 120,
                                                                                decoration: const BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                                  color: Colors.green,
                                                                                ),
                                                                                padding: const EdgeInsets.all(15),
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    'Yes, Verify',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 20),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ).visible(data[index].verificationStatus == 'pending'),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          ///_____status______________________________________
                                                          Positioned(
                                                            top: 0,
                                                            right: 0,
                                                            child: Container(
                                                              height: 60,
                                                              width: 150,
                                                              decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                                                color: data[index].verificationStatus == 'cancel' ? Colors.red : Colors.green,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  data[index].verificationStatus == 'cancel' ? 'Canceled' : 'Verified',
                                                                  style: const TextStyle(color: Colors.white),
                                                                ),
                                                              ),
                                                            ).visible(data[index].verificationStatus != 'pending'),
                                                          ),
                                                        ],
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
