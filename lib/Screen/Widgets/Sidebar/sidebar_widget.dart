// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salespro_saas_admin/Screen/Dashboard/dashboard.dart';
import 'package:salespro_saas_admin/Screen/NID%20Verification/nid_verification_screen.dart';
import 'package:salespro_saas_admin/Screen/Payment%20Verification/payment_verification_screen.dart';
import '../../../Homepage Advertising/homepage_advertising.dart';
import '../../Add user/add_user.dart';
import '../../Payment Settings/payment_settings_screen.dart';
import '../../Reports/reports.dart';
import '../../SMS Package/sms_package_screen.dart';
import '../../Shop Category/shop_category.dart';
import '../../Shop Management/shop_management.dart';
import '../../Subscription Plans/subscription_plans.dart';
import '../../Terms and Policy/terms_and_policy_screen.dart';
import '../../User Role/user_role_screen.dart';
import '../Constant Data/constant.dart';

List<String> titleList = [
  'Dashboard',
  'Shop List',
  'Shop Category',
  'Reports',
  'Subscription Plans',
  // 'SMS Package',
  'Payment Settings',
  'Homepage Advertising',
  'User Roles',
  'Add User',
  "Terms & Privacy",
  // 'NID Verification',
  // 'Payment Verification',
];

String selected = 'Dashboard';

List<IconData> iconList = [
  Icons.dashboard,
  Icons.home_work,
  FeatherIcons.box,
  FontAwesomeIcons.fileLines,
  Icons.subscriptions_outlined,
  // Icons.sms,
  Icons.paypal,
  Icons.video_settings_outlined,
  FeatherIcons.users,
  MdiIcons.accountMultiplePlus,
  Icons.policy,
  // Icons.credit_card_rounded,
  // Icons.payments_rounded
];

List<String> screenList = [
  MtDashboard.route,
  ShopManagement.route,
  ShopCategory.route,
  Reports.route,
  SubscriptionPlans.route,
  // SMSPackage.route,
  PaymentSettings.route,
  HomepageAdvertising.route,
  UserRoleScreen.route,
  AddUser.route,
  TermsAndPolicyScreen.route,
  // NIDVerificationScreen.route,
  // PaymentVerificationScreen.route,
];

List<String> tabletScreenList = [
  '/',
  MtDashboard.route,
  MtDashboard.route,
  MtDashboard.route,
  MtDashboard.route,
  MtDashboard.route,
  PaymentSettings.route,
  SubscriptionPlans.route,
  HomepageAdvertising.route,
];

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({Key? key, required this.index, required this.isTab}) : super(key: key);
  final int index;
  final bool isTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(color: kDarkGreyColor),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: kDarkGreyColor),
              child: ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: CircleAvatar(
                  radius: 16.0,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(sideBarLogo),
                ),
                title: Text(
                  appsName,
                  style: kTextStyle.copyWith(color: kWhiteTextColor),
                ),
                trailing: const Icon(
                  FeatherIcons.chevronRight,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ),
            const Divider(
              thickness: 1.0,
              color: kGreyTextColor,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: titleList.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: index == i ? kBlueTextColor : null,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          selectedTileColor: kBlueTextColor,
                          onTap: (() {
                            screenList[i] == Navigator.of(context).pushNamed(isTab ? tabletScreenList[i] : screenList[i]);
                            // screenList[i].launch(context);
                            selected = titleList[i];
                          }),
                          leading: Icon(iconList[i], color: kWhiteTextColor),
                          title: Text(
                            titleList[i],
                            style: kTextStyle.copyWith(color: kWhiteTextColor),
                          ),
                          trailing: const Icon(
                            FeatherIcons.chevronRight,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50.0),
            Text(
              appsName,
              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              'Version $version',
              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
