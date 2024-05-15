// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_admin/commas.dart';
import 'package:salespro_admin/generated/l10n.dart' as lang;
import '../../PDF/print_pdf.dart';
import '../../Provider/profile_provider.dart';
import '../../Provider/transactions_provider.dart';
import '../../const.dart';
import '../../model/sale_transaction_model.dart';
import '../../subscription.dart';
import '../POS Sale/pos_sale.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Constant Data/export_button.dart';
import '../Widgets/Footer/footer.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/TopBar/top_bar_widget.dart';

class QuotationList extends StatefulWidget {
  const QuotationList({Key? key}) : super(key: key);

  static const String route = '/quotationList';

  @override
  State<QuotationList> createState() => _QuotationListState();
}

class _QuotationListState extends State<QuotationList> {
  // void convertToSale(){
  //   if (widget.transitionModel.customerType == "Guest" && dueAmountController.text.toDouble() > 0) {
  //     EasyLoading.showError('Due is not available For Guest');
  //   } else {
  //     try {
  //       EasyLoading.show(status: 'Loading...', dismissOnTap: false);
  //       DatabaseReference ref = FirebaseDatabase.instance.ref("$constUserId/Sales Transition");
  //
  //       dueAmountController.text.toDouble() <= 0 ? widget.transitionModel.isPaid = true : widget.transitionModel.isPaid = false;
  //       dueAmountController.text.toDouble() <= 0
  //           ? widget.transitionModel.dueAmount = 0
  //           : widget.transitionModel.dueAmount = double.parse(dueAmountController.text);
  //       changeAmountController.text.toDouble() > 0
  //           ? widget.transitionModel.returnAmount = changeAmountController.text.toDouble().abs()
  //           : widget.transitionModel.returnAmount = 0;
  //       widget.transitionModel.totalAmount = widget.transitionModel.totalAmount!.toDouble().toDouble();
  //       widget.transitionModel.paymentType = selectedPaymentOption;
  //       widget.transitionModel.sellerName = isSubUser ? constSubUserTitle : 'Admin';
  //
  //       // ///_____sms_______________________________________________________
  //       // SmsModel smsModel = SmsModel(
  //       //   customerName: widget.transitionModel.customerName,
  //       //   customerPhone: widget.transitionModel.customerPhone,
  //       //   invoiceNumber: widget.transitionModel.invoiceNumber,
  //       //   dueAmount: widget.transitionModel.dueAmount.toString(),
  //       //   paidAmount:
  //       //       (widget.transitionModel.totalAmount!.toDouble() - widget.transitionModel.dueAmount!.toDouble()).toString(),
  //       //   sellerId: userId,
  //       //   sellerMobile: data.phoneNumber,
  //       //   sellerName: data.companyName,
  //       //   totalAmount: widget.transitionModel.totalAmount.toString(),
  //       //   status: false,
  //       // );
  //
  //       ///__________total LossProfit & quantity________________________________________________________________
  //       SaleTransactionModel post = checkLossProfit(transitionModel: widget.transitionModel);
  //
  //       ///_________Push_on_dataBase____________________________________________________________________________
  //       await ref.push().set(post.toJson());
  //
  //       ///________sms_post________________________________________________________________________
  //       // FirebaseDatabase.instance.ref('Admin Panel').child('Sms List').push().set(smsModel.toJson());
  //
  //       ///__________StockMange_________________________________________________________________________________
  //       final stockRef = FirebaseDatabase.instance.ref('$constUserId/Products/');
  //
  //       for (var element in widget.transitionModel.productList!) {
  //         var data = await stockRef.orderByChild('productCode').equalTo(element.productId).once();
  //         final data2 = jsonDecode(jsonEncode(data.snapshot.value));
  //         String productPath = data.snapshot.value.toString().substring(1, 21);
  //
  //         var data1 = await stockRef.child('$productPath/productStock').once();
  //         int stock = int.parse(data1.snapshot.value.toString());
  //         int remainStock = stock - element.quantity;
  //
  //         stockRef.child(productPath).update({'productStock': '$remainStock'});
  //
  //         ///________Update_Serial_Number____________________________________________________
  //
  //         if (element.serialNumber!.isNotEmpty) {
  //           var productOldSerialList = data2[productPath]['serialNumber'];
  //
  //           List<dynamic> result = productOldSerialList.where((item) => !element.serialNumber!.contains(item)).toList();
  //           stockRef.child(productPath).update({
  //             'serialNumber': result.map((e) => e).toList(),
  //           });
  //         }
  //       }
  //
  //       ///_________Invoice Increase____________________________________________________________________________
  //       updateInvoice(typeOfInvoice: 'saleInvoiceCounter', invoice: widget.transitionModel.invoiceNumber.toInt());
  //
  //       ///________Subscription_____________________________________________________
  //
  //       Subscription.decreaseSubscriptionLimits(itemType: 'saleNumber', context: context);
  //
  //       ///________daily_transactionModel_________________________________________________________________________
  //
  //       DailyTransactionModel dailyTransaction = DailyTransactionModel(
  //         name: post.customerName,
  //         date: post.purchaseDate,
  //         type: 'Sale',
  //         total: post.totalAmount!.toDouble(),
  //         paymentIn: post.totalAmount!.toDouble() - post.dueAmount!.toDouble(),
  //         paymentOut: 0,
  //         remainingBalance: post.totalAmount!.toDouble() - post.dueAmount!.toDouble(),
  //         id: post.invoiceNumber,
  //         saleTransactionModel: post,
  //       );
  //       postDailyTransaction(dailyTransactionModel: dailyTransaction);
  //
  //       ///_________DueUpdate___________________________________________________________________________________
  //       if (widget.transitionModel.customerName != 'Guest') {
  //         final dueUpdateRef = FirebaseDatabase.instance.ref('$constUserId/Customers/');
  //         String? key;
  //
  //         await FirebaseDatabase.instance.ref(constUserId).child('Customers').orderByKey().get().then((value) {
  //           for (var element in value.children) {
  //             var data = jsonDecode(jsonEncode(element.value));
  //             if (data['phoneNumber'] == widget.transitionModel.customerPhone) {
  //               key = element.key;
  //             }
  //           }
  //         });
  //         var data1 = await dueUpdateRef.child('$key/due').once();
  //         int previousDue = data1.snapshot.value.toString().toInt();
  //
  //         int totalDue = previousDue + widget.transitionModel.dueAmount!.toInt();
  //         dueUpdateRef.child(key!).update({'due': '$totalDue'});
  //       }
  //
  //       ///________update_all_provider___________________________________________________
  //
  //       consumerRef.refresh(allCustomerProvider);
  //       consumerRef.refresh(transitionProvider);
  //       consumerRef.refresh(productProvider);
  //       consumerRef.refresh(purchaseTransitionProvider);
  //       consumerRef.refresh(dueTransactionProvider);
  //       consumerRef.refresh(profileDetailsProvider);
  //       consumerRef.refresh(dailyTransactionProvider);
  //
  //       EasyLoading.showSuccess('Added Successfully');
  //       await GeneratePdfAndPrint().printSaleInvoice(personalInformationModel: data, saleTransactionModel: widget.transitionModel,context: context);
  //       // SaleInvoice(
  //       //   transitionModel: widget.transitionModel,
  //       //   personalInformationModel: data,
  //       //   isPosScreen: true,
  //       // ).launch(context);
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  //     }
  //   }
  // }
  ScrollController mainScroll = ScrollController();
  void deleteQuotation({required String date, required WidgetRef updateRef, required BuildContext context}) async {
    EasyLoading.show(status: 'Deleting..');
    String key = '';
    await FirebaseDatabase.instance.ref(await getUserID()).child('Sales Quotation').orderByKey().get().then((value) {
      for (var element in value.children) {
        var data = jsonDecode(jsonEncode(element.value));
        if (data['purchaseDate'].toString() == date) {
          key = element.key.toString();
        }
      }
    });
    DatabaseReference ref = FirebaseDatabase.instance.ref("${await getUserID()}/Sales Quotation/$key");
    await ref.remove();
    // ignore: unused_result
    updateRef.refresh(quotationProvider);
    Navigator.pop(context);

    EasyLoading.showSuccess('Done');
  }

  String searchItem = '';

  String quatationAmount='0';
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUserAndRestartApp();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kDarkWhite,
        body: Scrollbar(
          controller: mainScroll,
          child: SingleChildScrollView(
            controller: mainScroll,
            scrollDirection: Axis.horizontal,
            child: Consumer(builder: (_, ref, watch) {
              final transactionReport = ref.watch(quotationProvider);
              final profile = ref.watch(profileDetailsProvider);
              return transactionReport.when(data: (transaction) {
                // final reTransaction = transaction.reversed.toList();
                List<SaleTransactionModel> reTransaction = [];

                for (var element in transaction.reversed.toList()) {
                  if (searchItem != '' &&
                      (element.customerName.removeAllWhiteSpace().toLowerCase().contains(searchItem.toLowerCase()) ||
                          element.invoiceNumber.toLowerCase().contains(searchItem.toLowerCase()))) {
                    reTransaction.add(element);
                  } else if (searchItem == '') {
                    reTransaction.add(element);
                  }
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 240,
                      child: SideBarWidget(
                        index: 1,
                        isTab: false,
                        subManu: lang.S.of(context).quotationList,
                      ),
                    ),
                    Container(
                      // width: context.width() < 1080 ? 1080 - 240 : MediaQuery.of(context).size.width - 240,
                      width: MediaQuery.of(context).size.width < 1275 ? 1275 - 240 : MediaQuery.of(context).size.width - 240,
                      decoration: const BoxDecoration(color: kDarkWhite),
                      child:  SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Row(
                                      children: [
                                        Text(
                                          lang.S.of(context).quotationList,
                                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                                        ),
                                        const Spacer(),

                                        ///___________search________________________________________________-
                                        Container(
                                          height: 40.0,
                                          width: 300,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), border: Border.all(color: kGreyTextColor.withOpacity(0.1))),
                                          child: AppTextField(
                                            showCursor: true,
                                            cursorColor: kTitleColor,
                                            onChanged: (value) {
                                              setState(() {
                                                searchItem = value;
                                              });
                                            },
                                            textFieldType: TextFieldType.NAME,
                                            decoration: kInputDecoration.copyWith(
                                              contentPadding: const EdgeInsets.all(10.0),
                                              hintText: (lang.S.of(context).searchByInvoiceOrName),
                                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                              border: InputBorder.none,
                                              enabledBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                                              ),
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Container(
                                                    padding: const EdgeInsets.all(2.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30.0),
                                                      color: kGreyTextColor.withOpacity(0.1),
                                                    ),
                                                    child: const Icon(
                                                      FeatherIcons.search,
                                                      color: kTitleColor,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    Divider(
                                      thickness: 1.0,
                                      color: kGreyTextColor.withOpacity(0.2),
                                    ),

                                    ///_______sale_List_____________________________________________________

                                    const SizedBox(height: 20.0),
                                    reTransaction.isNotEmpty
                                        ? Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: const BoxDecoration(color: kbgColor),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(width: 50, child: Text('S.L')),
                                              SizedBox(width: 85, child: Text(lang.S.of(context).date)),
                                              SizedBox(width: 50, child: Text(lang.S.of(context).invoice)),
                                              SizedBox(width: 180, child: Text(lang.S.of(context).partyName)),
                                              SizedBox(width: 100, child: Text(lang.S.of(context).type)),
                                              SizedBox(width: 70, child: Text(lang.S.of(context).amount)),
                                              const SizedBox(width: 30, child: Icon(FeatherIcons.settings)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height:(MediaQuery.of(context).size.height - 315).isNegative? 0:MediaQuery.of(context).size.height - 315,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: const AlwaysScrollableScrollPhysics(),
                                            itemCount: reTransaction.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(15),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        ///______________S.L__________________________________________________
                                                        SizedBox(
                                                          width: 50,
                                                          child: Text((index + 1).toString(), style: kTextStyle.copyWith(color: kGreyTextColor)),
                                                        ),

                                                        ///______________Date__________________________________________________
                                                        SizedBox(
                                                          width: 85,
                                                          child: Text(
                                                            reTransaction[index].purchaseDate.substring(0, 10),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2, style: kTextStyle.copyWith(color: kGreyTextColor,overflow: TextOverflow.ellipsis),
                                                          ),
                                                        ),

                                                        ///____________Invoice_________________________________________________
                                                        SizedBox(
                                                          width: 50,
                                                          child: Text(reTransaction[index].invoiceNumber,
                                                              maxLines: 2, overflow: TextOverflow.ellipsis, style: kTextStyle.copyWith(color: kGreyTextColor)),
                                                        ),

                                                        ///______Party Name___________________________________________________________
                                                        SizedBox(
                                                          width: 180,
                                                          child: Text(
                                                            reTransaction[index].customerName,
                                                            style: kTextStyle.copyWith(color: kGreyTextColor),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),

                                                        ///___________Type______________________________________________

                                                        SizedBox(
                                                          width: 100,
                                                          child: Text(
                                                            lang.S.of(context).quotation,
                                                            style: kTextStyle.copyWith(color: kGreyTextColor),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),

                                                        ///___________Amount____________________________________________________
                                                        SizedBox(
                                                          width: 70,
                                                          child: Text(
                                                            myFormat.format(int.tryParse(reTransaction[index].totalAmount.toString())??0),
                                                            style: kTextStyle.copyWith(color: kGreyTextColor),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),

                                                        ///_______________actions_________________________________________________
                                                        SizedBox(
                                                          width: 30,
                                                          child: Theme(
                                                            data: ThemeData(
                                                                highlightColor: dropdownItemColor,
                                                                focusColor: dropdownItemColor,
                                                                hoverColor: dropdownItemColor
                                                            ),
                                                            child: PopupMenuButton(
                                                              surfaceTintColor: Colors.white,
                                                              padding: EdgeInsets.zero,
                                                              itemBuilder: (BuildContext bc) => [
                                                                PopupMenuItem(
                                                                  child: GestureDetector(
                                                                    onTap: () async {
                                                                      await GeneratePdfAndPrint().printQuotationInvoice(
                                                                          personalInformationModel: profile.value!, saleTransactionModel: reTransaction[index]);
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(MdiIcons.printer, size: 18.0, color: kTitleColor),
                                                                        const SizedBox(width: 4.0),
                                                                        Text(
                                                                          lang.S.of(context).print,
                                                                          style: kTextStyle.copyWith(color: kTitleColor),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                PopupMenuItem(
                                                                  child: GestureDetector(
                                                                    onTap: () {
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
                                                                                      Text(
                                                                                        lang.S.of(context).areYouWantToDeleteThisQuotion,
                                                                                        style: const TextStyle(fontSize: 22),
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
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  lang.S.of(context).cancel,
                                                                                                  style: TextStyle(color: Colors.white),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            onTap: () {
                                                                                              Navigator.pop(dialogContext);
                                                                                              Navigator.pop(bc);
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
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  lang.S.of(context).delete,
                                                                                                  style: TextStyle(color: Colors.white),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            onTap: () {
                                                                                              deleteQuotation(
                                                                                                  date: reTransaction[index].purchaseDate, updateRef: ref, context: bc);
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
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(Icons.delete, size: 18.0, color: kTitleColor),
                                                                        const SizedBox(width: 4.0),
                                                                        Text(
                                                                          lang.S.of(context).delete,
                                                                          style: kTextStyle.copyWith(color: kTitleColor),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                PopupMenuItem(
                                                                  child: GestureDetector(
                                                                    onTap: () async {
                                                                      if (await Subscription.subscriptionChecker(item: '/posSale')) {
                                                                        Navigator.push(context, MaterialPageRoute(
                                                                          builder: (context) {
                                                                            return PosSale(
                                                                              quotation: reTransaction[index],
                                                                            );
                                                                          },
                                                                        ));
                                                                        // ShowPaymentPopUp(
                                                                        //   transitionModel: reTransaction[index],
                                                                        //   isFromQuotation: true,
                                                                        // ).launch(context);
                                                                      } else {
                                                                        EasyLoading.showError('Update your plan first\nSale Limit is over.');
                                                                      }
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(Icons.point_of_sale_sharp, size: 18.0, color: kTitleColor),
                                                                        const SizedBox(width: 4.0),
                                                                        Text(
                                                                          lang.S.of(context).convertToSale,
                                                                          style: kTextStyle.copyWith(color: kTitleColor),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                              child: Center(
                                                                child: Container(
                                                                    height: 18,
                                                                    width: 18,
                                                                    alignment: Alignment.centerRight,
                                                                    child: const Icon(
                                                                      Icons.more_vert_sharp,
                                                                      size: 18,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 1,
                                                    color: kGreyTextColor.withOpacity(0.2),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                        :  EmptyWidget(title: lang.S.of(context).noQuotionFound,),
                                  ],
                                ),
                              ),
                            ),
                            const Footer(),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }, error: (e, stack) {
                return Center(
                  child: Text(e.toString()),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
            }),
          ),
        ),
      ),
    );
  }
}


