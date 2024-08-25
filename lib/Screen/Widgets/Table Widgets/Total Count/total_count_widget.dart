import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salespro_saas_admin/Screen/Widgets/Constant%20Data/constant.dart';

class TotalCount extends StatelessWidget {
  const TotalCount({Key? key, required this.title, required this.count, required this.icon, required this.backgroundColor, required this.iconBgColor})
      : super(key: key);

  final String title;
  final String count;
  final Color iconBgColor;
  final String icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor,
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: EdgeInsets.all(10.0),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBgColor
                ),
                child: SvgPicture.asset(
                  icon,
                  height: 28.0,
                  width: 28.0,
                  allowDrawingOutsideViewBox: false,
                  fit: BoxFit.cover,
                ),
              ),
              subtitle: Text(
                title,
                style: kTextStyle.copyWith(color: kGreyTextColor),
                maxLines: 1,
              ),
              title: Text(
                count,
                style: kTextStyle.copyWith(color: kTitleColor, fontSize: 21.0, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget(
      {Key? key,
      required this.title,
      required this.count,
      required this.icon,
      required this.percentageColor,
      required this.iconColor,
      required this.countPercentage,
      required this.lastMonth,
      required this.currentYear,
      this.arrowIcon,
      this.arrowIconColor, required this.bgColor})
      : super(key: key);

  final String title;
  final String count;
  final String lastMonth;
  final String currentYear;
  final String countPercentage;
  final Color iconColor;
  final IconData icon;
  final IconData? arrowIcon;
  final Color? arrowIconColor;
  final Color percentageColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 0.0,
      shadowColor: kGreyTextColor,
      child: Container(
        height:142,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: RichText(
                  text: TextSpan(
                text: title, style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),

              )),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      count,
                      style: kTextStyle.copyWith(color: kTitleColor, fontSize: 21.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5.0),
                    Icon(arrowIcon, color: arrowIconColor),
                    RichText(
                      text: TextSpan(
                        text: countPercentage,
                        style: kTextStyle.copyWith(color: percentageColor, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: '  Monthly',
                              style: kTextStyle.copyWith(color: kGreyTextColor, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))
                        ],
                      ),
                    ),
                    // const SizedBox(width: 4.0),
                    // Text('Monthly',style: kTextStyle.copyWith(color: kGreyTextColor),overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Last Month:', style: kTextStyle.copyWith(color: kGreyTextColor), overflow: TextOverflow.ellipsis),
                const SizedBox(width: 4.0),

                Text(lastMonth, style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Total(Current Year)',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4.0),
                Text(currentYear, style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class YearlyInfoWidget extends StatelessWidget {
  const YearlyInfoWidget(
      {Key? key,
      required this.title,
      required this.count,
      required this.icon,
      required this.percentageColor,
      required this.iconColor,
      required this.countPercentage,
      required this.lastYear,
      required this.currentYear,
      this.arrowIcon,
      this.arrowIconColor, required this.bgColor})
      : super(key: key);

  final String title;
  final String count;
  final String lastYear;
  final String currentYear;
  final String countPercentage;
  final Color iconColor;
  final IconData icon;
  final IconData? arrowIcon;
  final Color? arrowIconColor;
  final Color percentageColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 0.0,
      shadowColor: kGreyTextColor,
      child: Container(
        height:142,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: RichText(
                  text: TextSpan(
                text: title, style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),

              )),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      count,
                      style: kTextStyle.copyWith(color: kTitleColor, fontSize: 21.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5.0),
                    Icon(arrowIcon, color: arrowIconColor),
                    RichText(
                      text: TextSpan(
                        text: countPercentage,
                        style: kTextStyle.copyWith(color: percentageColor, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: '  This Year',
                              style: kTextStyle.copyWith(color: kGreyTextColor, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))
                        ],
                      ),
                    ),
                    // const SizedBox(width: 4.0),
                    // Text('Monthly',style: kTextStyle.copyWith(color: kGreyTextColor),overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Last Year:', style: kTextStyle.copyWith(color: kGreyTextColor), overflow: TextOverflow.ellipsis),
                const SizedBox(width: 4.0),

                Text(lastYear, style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Total(Current Year)',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4.0),
                Text(currentYear, style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
