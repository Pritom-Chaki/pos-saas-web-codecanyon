import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:salespro_saas_admin/Screen/Widgets/Constant%20Data/constant.dart';

import '../../model/payment_verification_model.dart';

class PaymentVerificationDetails extends StatefulWidget {
  const PaymentVerificationDetails({Key? key, required this.infoModel}) : super(key: key);

  final PaymentVerificationModel infoModel;

  @override
  State<PaymentVerificationDetails> createState() => _PaymentVerificationDetailsState();
}

class _PaymentVerificationDetailsState extends State<PaymentVerificationDetails> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Payment Verification Details',
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
                    'Seller Name',
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
                        widget.infoModel.sellerName,
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
                        widget.infoModel.shopName,
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
                    'Seller Phone',
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
                        widget.infoModel.sellerPhone,
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
                    'Payee Phone Number',
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
                        widget.infoModel.paymentPhoneNumber,
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
                    'Paid Amount',
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
                        widget.infoModel.paidAmount.toString(),
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
                    'Transaction ID',
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
                        widget.infoModel.transactionId,
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
                    'Payment Date',
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
                        widget.infoModel.verificationAttemptsDate.substring(0, 10),
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
                    'Verification Status',
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
                        widget.infoModel.verificationStatus,
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
                    'Payment Date',
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
                        widget.infoModel.verificationAttemptsDate.substring(0, 10),
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///__________ref_____________________________________________
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Payment Ref',
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
                        widget.infoModel.paymentRef,
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///__________SMS Package Name_____________________________________________
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'SMS Package Name',
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
                        widget.infoModel.smsSubscriptionPlanModel.smsPackName,
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///__________SMS Package Price_____________________________________________
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'SMS Package Price',
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
                        widget.infoModel.smsSubscriptionPlanModel.smsPackPrice.toString(),
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///__________SMS Package Name_____________________________________________
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'SMS Offer Price',
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
                        widget.infoModel.smsSubscriptionPlanModel.smsPackOfferPrice.toString(),
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///__________SMS Number_____________________________________________
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Number Of SMS',
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
                        widget.infoModel.smsSubscriptionPlanModel.numberOfSMS.toString(),
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///__________SMS velidity_____________________________________________
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'SMS Validity',
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
                        widget.infoModel.smsSubscriptionPlanModel.smsValidityInDay.toString(),
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
