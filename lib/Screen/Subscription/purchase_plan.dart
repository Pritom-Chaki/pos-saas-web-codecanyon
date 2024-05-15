import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_admin/Screen/Subscription/payment.dart';
import 'package:salespro_admin/Screen/Subscription/subscript.dart';
import '../../Provider/subacription_plan_provider.dart';
import '../../Repository/subscriptionPlanRepo.dart';
import '../../const.dart';
import '../../currency.dart';
import '../../model/subscription_model.dart';
import '../../model/subscription_plan_model.dart';
import '../Widgets/Constant Data/constant.dart';
import 'package:salespro_admin/generated/l10n.dart' as lang;
import '../Widgets/Footer/footer.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';

import '../Widgets/TopBar/top_bar_widget.dart';

class PurchasePlan extends StatefulWidget {
  const PurchasePlan({
    Key? key,
    required this.initialSelectedPackage,
    required this.initPackageValue,
  }) : super(key: key);
  final String initialSelectedPackage;
  final int initPackageValue;
  static const String route = '/purchase_plan';

  @override
  // ignore: library_private_types_in_public_api
  _PurchasePlanState createState() => _PurchasePlanState();
}

class _PurchasePlanState extends State<PurchasePlan> {
  ScrollController mainScroll = ScrollController();

  String selectedPayButton = 'Paypal';
  int selectedPackageValue = 0;

  CurrentSubscriptionPlanRepo currentSubscriptionPlanRepo = CurrentSubscriptionPlanRepo();

  SubscriptionModel currentSubscriptionPlan = SubscriptionModel(
    subscriptionName: 'Free',
    subscriptionDate: DateTime.now().toString(),
    saleNumber: 0,
    purchaseNumber: 0,
    partiesNumber: 0,
    dueNumber: 0,
    duration: 0,
    products: 0,
  );

  void getCurrentSubscriptionPlan() async {
    currentSubscriptionPlan = await currentSubscriptionPlanRepo.getCurrentSubscriptionPlans();
    setState(() {
      currentSubscriptionPlan;
    });
  }

  @override
  initState() {
    super.initState();
    checkCurrentUserAndRestartApp();
    getCurrentSubscriptionPlan();
    widget.initPackageValue == 0 ? selectedPackageValue = 2 : 0;
  }

  List<Color> colors = [
    const Color(0xFF06DE90),
    const Color(0xFFF5B400),
    const Color(0xFFFF7468),
  ];
  SubscriptionPlanModel selectedPlan =
      SubscriptionPlanModel(subscriptionName: '', saleNumber: 0, purchaseNumber: 0, partiesNumber: 0, dueNumber: 0, duration: 0, products: 0, subscriptionPrice: 0, offerPrice: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      body: Consumer(builder: (context, ref, __) {
        final subscriptionData = ref.watch(subscriptionPlanProvider);
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
                subscriptionData.when(data: (data) {
                  return Container(
                    width: MediaQuery.of(context).size.width < 1275 ? 1275 - 240 : MediaQuery.of(context).size.width - 240,
                    // width: context.width() < 1080 ? 1080 - 240 : MediaQuery.of(context).size.width - 240,
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
                                  const SizedBox(height: 10),
                                   Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      lang.S.of(context).buyPremiumPlan,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 225,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedPlan = data[index];
                                            });
                                          },
                                          child: data[index].offerPrice >= 1
                                              ? Padding(
                                                  padding: const EdgeInsets.only(right: 10),
                                                  child: SizedBox(
                                                    height: (context.width() / 2.5) + 18,
                                                    child: Stack(
                                                      alignment: Alignment.bottomCenter,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color:
                                                                data[index].subscriptionName == selectedPlan.subscriptionName ? kPremiumPlanColor2.withOpacity(0.1) : Colors.white,
                                                            borderRadius: const BorderRadius.all(
                                                              Radius.circular(10),
                                                            ),
                                                            border: Border.all(
                                                              width: 1,
                                                              color: data[index].subscriptionName == selectedPlan.subscriptionName ? kPremiumPlanColor2 : kPremiumPlanColor,
                                                            ),
                                                          ),
                                                          padding: const EdgeInsets.all(10.0),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              const SizedBox(height: 15),
                                                               Text(
                                                                lang.S.of(context).mobilePlusDesktop,
                                                                textAlign: TextAlign.center,
                                                                style: const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 15),
                                                              Text(
                                                                data[index].subscriptionName,
                                                                style: const TextStyle(fontSize: 16),
                                                              ),
                                                              const SizedBox(height: 5),
                                                              Text(
                                                                '$currency${data[index].offerPrice}',
                                                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPremiumPlanColor2),
                                                              ),
                                                              Text(
                                                                '$currency${data[index].subscriptionPrice}',
                                                                style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 14, color: Colors.grey),
                                                              ),
                                                              const SizedBox(height: 5),
                                                              Text(
                                                                'Duration ${data[index].duration} Day',
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
                                                              color: kPremiumPlanColor2,
                                                              borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(10),
                                                                bottomRight: Radius.circular(10),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Save ${(100 - ((data[index].offerPrice * 100) / data[index].subscriptionPrice)).toInt().toString()}%',
                                                                style: const TextStyle(color: Colors.white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets.only(bottom: 20, right: 10),
                                                  child: Container(
                                                    padding: const EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                      color: data[index].subscriptionName == selectedPlan.subscriptionName ? kPremiumPlanColor2.withOpacity(0.1) : Colors.white,
                                                      borderRadius: const BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                          width: 1, color: data[index].subscriptionName == selectedPlan.subscriptionName ? kPremiumPlanColor2 : kPremiumPlanColor),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                         Text(
                                                          lang.S.of(context).mobilePlusDesktop,
                                                          textAlign: TextAlign.center,
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 15),
                                                        Text(
                                                          data[index].subscriptionName,
                                                          style: const TextStyle(fontSize: 16),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text(
                                                          '$currency${data[index].subscriptionPrice.toString()}',
                                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPremiumPlanColor),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text(
                                                          'Duration ${data[index].duration} Day',
                                                          style: const TextStyle(color: kGreyTextColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Center(
                                    child: SizedBox(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width < 1080 ? 1080 * .30 : MediaQuery.of(context).size.width * .30,
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
                                          if (selectedPlan.subscriptionName == '') {
                                            EasyLoading.showError('Please Select a Plan');
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PaymentScreen(
                                                  subscriptionPlanModel: selectedPlan,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          lang.S.of(context).payNow,
                                          style: kTextStyle.copyWith(color: kWhiteTextColor, fontSize: 18.0),
                                        ),
                                      ),
                                    ),
                                  ).visible(Subscript.customersActivePlan.subscriptionName != selectedPlan.subscriptionName),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height:20.0),
                          const Footer(),
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
