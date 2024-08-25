import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salespro_saas_admin/Screen/Widgets/Constant%20Data/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../currency.dart';
import '../../../../model/seller_info_model.dart';
import '../../../../model/subscription_request_model.dart';
import '../Total Count/total_count_widget.dart';

//Top Selling Store
class TopSellingStore extends StatelessWidget {
  const TopSellingStore({Key? key, required this.newReg1, required this.monthlyReg, required this.previousReg, required this.totalUSer}) : super(key: key);
  final List<SellerInfoModel> newReg1;
  final List<SellerInfoModel> monthlyReg;
  final List<SellerInfoModel> previousReg;
  final String totalUSer;

  @override
  Widget build(BuildContext context) {
    List<SellerInfoModel> newReg = newReg1.reversed.toList();
    List<int> userCounts = [];
    int currentMonthUserCount = monthlyReg.length;
    userCounts.add(currentMonthUserCount);

    int previousMonthUserCount = previousReg.length;
    userCounts.add(previousMonthUserCount);

    double percentageChange = 0.0;
    if (previousMonthUserCount > 0) {
      percentageChange = ((currentMonthUserCount - previousMonthUserCount) / previousMonthUserCount) * 100;
    } else if (previousMonthUserCount == 0) {
      // Handle the case where previousMonthUserCount is 0
      percentageChange = (currentMonthUserCount - previousMonthUserCount) * 100;
    } else {
      percentageChange = ((currentMonthUserCount - previousMonthUserCount).abs() / previousMonthUserCount.abs()) * 100;
    }

    return Column(
      children: [
        SizedBox(
          child: InfoWidget(
              title: 'Total New Users',
              count: currentMonthUserCount.toString(),
              icon: MdiIcons.accountGroup,
              percentageColor: percentageChange >= 0 ? Colors.green : Colors.red,
              iconColor: Colors.blueGrey,
              countPercentage: '${percentageChange.toStringAsFixed(2)}%',
              // Removed the space before '%'
              lastMonth: previousMonthUserCount.toString(),
              currentYear: totalUSer.toString(),
              arrowIcon: percentageChange >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              // Removed .toString()
              arrowIconColor: percentageChange >= 0 ? Colors.green : Colors.red,
              bgColor: Color(0xFfFFE9E0)),
        ),
      ],
    );
  }
}

//Lifetime Subscribed
class Subscribed extends StatefulWidget {
  const Subscribed({
    Key? key,
    required this.subOfCurrentYear,
    required this.subOfCurrentMonth,
    required this.subOfLastMonth,
    required this.totalNewUserCurrentYear,
    required this.userInMonthOfYear,
  }) : super(key: key);
  final List<SubscriptionRequestModel> subOfCurrentYear;
  final List<SubscriptionRequestModel> subOfCurrentMonth;
  final List<SubscriptionRequestModel> subOfLastMonth;
  final int totalNewUserCurrentYear;
  final List<double> userInMonthOfYear;

  @override
  State<Subscribed> createState() => _SubscribedState();
}

class _SubscribedState extends State<Subscribed> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 40),
    _SalesData('Jul', 40),
    _SalesData('Aug', 40),
    _SalesData('Sep', 40),
    _SalesData('Oct', 40),
    _SalesData('Nov', 0),
    _SalesData('Dec', 0),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [
      _SalesData('Jan', widget.userInMonthOfYear[0]),
      _SalesData('Feb', widget.userInMonthOfYear[1]),
      _SalesData('Mar', widget.userInMonthOfYear[2]),
      _SalesData('Apr', widget.userInMonthOfYear[3]),
      _SalesData('May', widget.userInMonthOfYear[4]),
      _SalesData('Jun', widget.userInMonthOfYear[5]),
      _SalesData('Jul', widget.userInMonthOfYear[6]),
      _SalesData('Aug', widget.userInMonthOfYear[7]),
      _SalesData('Sep', widget.userInMonthOfYear[8]),
      _SalesData('Oct', widget.userInMonthOfYear[9]),
      _SalesData('Nov', widget.userInMonthOfYear[10]),
      _SalesData('Dec', widget.userInMonthOfYear[11]),
    ];
  }

  double persent() {
    double percentageChange = 0.0;
    if (widget.subOfLastMonth.isNotEmpty) {
      percentageChange = ((widget.subOfCurrentMonth.length - widget.subOfLastMonth.length) / widget.subOfLastMonth.length) * 100;
    } else if (widget.subOfLastMonth.isEmpty) {
      // Handle the case where previousMonthUserCount is 0
      percentageChange = (widget.subOfCurrentMonth.length - widget.subOfLastMonth.length) * 100;
    } else {
      percentageChange = ((widget.subOfCurrentMonth.length - widget.subOfLastMonth.length).abs() / widget.subOfLastMonth.length.abs()) * 100;
    }
    return percentageChange;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: InfoWidget(
            title: 'Total New Subscribe',
            count: '${widget.subOfCurrentMonth.length}',
            icon: MdiIcons.trophyAward,
            percentageColor: persent() >= 0 ? Colors.green : Colors.red,
            iconColor: Colors.blueGrey,
            countPercentage: '${persent().toStringAsFixed(0)}% ',
            lastMonth: '${widget.subOfLastMonth.length}',
            arrowIcon: persent() >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            // Removed .toString()
            arrowIconColor: persent() >= 0 ? Colors.green : Colors.red,
            currentYear: '${widget.subOfCurrentYear.length}',
            bgColor: Color(0xFFDAFCFF),
          ),
        ),
        // const SizedBox(height: 20.0),
        // Container(
        //   padding: const EdgeInsets.all(10.0),
        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       ListTile(
        //         contentPadding: EdgeInsets.zero,
        //         horizontalTitleGap: 0,
        //         leading: Icon(
        //           MdiIcons.accountGroupOutline,
        //           color: kGreyTextColor,
        //         ),
        //         title: Text(
        //           'Lifetime Subscribed',
        //           style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //       Row(
        //         children: List.generate(
        //             800 ~/ 5,
        //             (index) => Expanded(
        //                   child: Container(
        //                     color: index % 2 == 0 ? Colors.transparent : Colors.grey,
        //                     height: 1,
        //                   ),
        //                 )),
        //       ),
        //     ],
        //   ),
        // ),
        // Card(
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        //   elevation: 2.0,
        //   shadowColor: kGreyTextColor,
        //   child: Container(
        //       height: 420,
        //       padding: const EdgeInsets.all(10.0),
        //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Row(
        //             children: [
        //               Icon(MdiIcons.accountGroup, color: CupertinoColors.activeBlue, size: 16),
        //               const SizedBox(width: 5.0),
        //               Text(
        //                 'Total New Users',
        //                 style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(height: 10.0),
        //           Text(
        //             "${widget.totalNewUserCurrentYear}",
        //             style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 21),
        //           ),
        //           Text(
        //             'Total New Users current year',
        //             style: kTextStyle.copyWith(color: kGreyTextColor),
        //           ),
        //           const SizedBox(height: 20.0),
        //           SfCartesianChart(
        //               primaryXAxis: CategoryAxis(),
        //               plotAreaBorderColor: Colors.transparent,
        //
        //               // Chart title
        //               // title: ChartTitle(text: 'Half yearly sales analysis'),
        //               // Enable legend
        //               legend: const Legend(isVisible: true, alignment: ChartAlignment.center, position: LegendPosition.bottom),
        //               tooltipBehavior: TooltipBehavior(enable: true),
        //               series: <ChartSeries<_SalesData, String>>[
        //                 ColumnSeries<_SalesData, String>(
        //                     legendIconType: LegendIconType.rectangle,
        //                     dataSource: data,
        //                     xValueMapper: (_SalesData sales, _) => sales.month,
        //                     yValueMapper: (_SalesData sales, _) => sales.sales,
        //                     name: 'Total New Registered Users',
        //                     color: Colors.black,
        //                     borderRadius: const BorderRadius.only(
        //                       topRight: Radius.circular(30.0),
        //                       topLeft: Radius.circular(30.0),
        //                     ),
        //                     // Enable data label
        //                     dataLabelSettings: const DataLabelSettings(isVisible: false)),
        //               ]),
        //         ],
        //       )
        //
        //       // ListView.builder(
        //       //   itemCount: lifeTimeSeller.length < 5 ? lifeTimeSeller.length : 5,
        //       //   shrinkWrap: true,
        //       //   physics: const NeverScrollableScrollPhysics(),
        //       //   itemBuilder: (_, i) {
        //       //     return ListTile(
        //       //       contentPadding: EdgeInsets.zero,
        //       //       horizontalTitleGap: 20,
        //       //       leading: CircleAvatar(
        //       //         radius: 20.0,
        //       //         backgroundImage: NetworkImage(lifeTimeSeller[i].pictureUrl ?? ''),
        //       //       ),
        //       //       title: Text(
        //       //         lifeTimeSeller[i].companyName.toString(),
        //       //         style: kTextStyle.copyWith(color: kTitleColor),
        //       //       ),
        //       //       subtitle: Text(
        //       //         lifeTimeSeller[i].businessCategory.toString(),
        //       //         style: kTextStyle.copyWith(color: kBlueTextColor),
        //       //       ),
        //       //       trailing: Text(
        //       //         lifeTimeSeller[i].subscriptionDate.toString().substring(0, 10),
        //       //         style: kTextStyle.copyWith(color: kTitleColor),
        //       //       ),
        //       //     );
        //       //   },
        //       // ),
        //       ),
        // ),
      ],
    );
  }
}

//Expired Shop
class IncomeSection extends StatefulWidget {
  const IncomeSection({
    Key? key,
    required this.totalIncomeCurrentYear,
    required this.totalIncomeCurrentMonths,
    required this.totalIncomeLastMonth,
    required this.allMonthData,
  }) : super(key: key);

  final double totalIncomeCurrentYear;
  final double totalIncomeCurrentMonths;
  final double totalIncomeLastMonth;
  final List<double> allMonthData;

  @override
  State<IncomeSection> createState() => _IncomeSectionState();
}

class _IncomeSectionState extends State<IncomeSection> {
  List<_SalesData> data = [
    _SalesData('Jan', 0),
    _SalesData('Feb', 0),
    _SalesData('Mar', 0),
    _SalesData('Apr', 0),
    _SalesData('May', 0),
    _SalesData('Jun', 0),
    _SalesData('Jul', 0),
    _SalesData('Aug', 0),
    _SalesData('Sep', 0),
    _SalesData('Oct', 0),
    _SalesData('Nov', 0),
    _SalesData('Dec', 0),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [
      _SalesData('Jan', widget.allMonthData[0]),
      _SalesData('Feb', widget.allMonthData[1]),
      _SalesData('Mar', widget.allMonthData[2]),
      _SalesData('Apr', widget.allMonthData[3]),
      _SalesData('May', widget.allMonthData[4]),
      _SalesData('Jun', widget.allMonthData[5]),
      _SalesData('Jul', widget.allMonthData[6]),
      _SalesData('Aug', widget.allMonthData[7]),
      _SalesData('Sep', widget.allMonthData[8]),
      _SalesData('Oct', widget.allMonthData[9]),
      _SalesData('Nov', widget.allMonthData[10]),
      _SalesData('Dec', widget.allMonthData[11]),
    ];
  }

  double persent() {
    double percentageChange = 0.0;
    if (widget.totalIncomeLastMonth > 0) {
      percentageChange = ((widget.totalIncomeCurrentMonths - widget.totalIncomeLastMonth) / widget.totalIncomeLastMonth) * 100;
    } else if (widget.totalIncomeLastMonth == 0) {
      // Handle the case where previousMonthUserCount is 0
      percentageChange = (widget.totalIncomeCurrentMonths - widget.totalIncomeLastMonth) * 100;
    } else {
      percentageChange = ((widget.totalIncomeCurrentMonths - widget.totalIncomeLastMonth).abs() / widget.totalIncomeLastMonth.abs()) * 100;
    }
    return percentageChange;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: InfoWidget(
            title: 'Total Income',
            count: '$currency ${widget.totalIncomeCurrentMonths}',
            icon: MdiIcons.wallet,
            percentageColor: persent() >= 0 ? Colors.green : Colors.red,
            iconColor: Colors.blueGrey,
            countPercentage: '${persent().toStringAsFixed(0)}% ',

            lastMonth: '$currency ${widget.totalIncomeLastMonth.toStringAsFixed(0)}',
            currentYear: '$currency ${widget.totalIncomeCurrentYear.toStringAsFixed(0)}',
            arrowIcon: persent() >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            // Removed .toString()
            arrowIconColor: persent() >= 0 ? Colors.green : Colors.red,
            bgColor: Color(0xFfE3E9FE),
          ),
        ),
        // const SizedBox(height: 20),
        // Container(
        //   padding: const EdgeInsets.all(10.0),
        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
        //   child: Column(
        //     children: [
        //       ListTile(
        //         contentPadding: EdgeInsets.zero,
        //         horizontalTitleGap: 0,
        //         leading: Icon(
        //           MdiIcons.clockAlertOutline,
        //           color: kGreyTextColor,
        //         ),
        //         title: Text(
        //           'Expired Shop',
        //           style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
        //         ),
        //         trailing: Text(
        //           'Package',
        //           style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //       Row(
        //         children: List.generate(
        //             800 ~/ 5,
        //             (index) => Expanded(
        //                   child: Container(
        //                     color: index % 2 == 0 ? Colors.transparent : Colors.grey,
        //                     height: 1,
        //                   ),
        //                 )),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 20),
        // Card(
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        //   elevation: 2.0,
        //   shadowColor: kGreyTextColor,
        //   child: Container(
        //       height: 420,
        //       padding: const EdgeInsets.all(10.0),
        //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Row(
        //             children: [
        //               Icon(MdiIcons.cardAccountDetails, color: CupertinoColors.activeBlue, size: 16),
        //               const SizedBox(width: 5.0),
        //               Text(
        //                 'Finance overview',
        //                 style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(height: 10.0),
        //           Text(
        //             '$currency ${widget.totalIncomeCurrentYear}',
        //             style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 21),
        //           ),
        //           Text(
        //             'Total Earnings current year',
        //             style: kTextStyle.copyWith(color: kGreyTextColor),
        //           ),
        //           const SizedBox(height: 20.0),
        //           SfCartesianChart(
        //               primaryXAxis: CategoryAxis(),
        //               plotAreaBorderColor: Colors.transparent,
        //               // Chart title
        //               // title: ChartTitle(text: 'Half yearly sales analysis'),
        //               // Enable legend
        //               legend: const Legend(isVisible: true, alignment: ChartAlignment.center, position: LegendPosition.bottom),
        //               // Enable tooltip
        //               tooltipBehavior: TooltipBehavior(enable: true),
        //               series: <ChartSeries<_SalesData, String>>[
        //                 ColumnSeries<_SalesData, String>(
        //                     legendIconType: LegendIconType.rectangle,
        //                     dataSource: data,
        //                     xValueMapper: (_SalesData sales, _) => sales.month,
        //                     yValueMapper: (_SalesData sales, _) => sales.sales,
        //                     name: 'Total Income ($currency)',
        //                     color: Colors.deepOrangeAccent,
        //                     borderRadius: const BorderRadius.only(
        //                       topRight: Radius.circular(
        //                         30.0,
        //                       ),
        //                       topLeft: Radius.circular(30.0),
        //                     ),
        //                     // Enable data label
        //                     dataLabelSettings: const DataLabelSettings(isVisible: false)),
        //               ]),
        //         ],
        //       )
        //
        //       // ListView.builder(
        //       //   itemCount: widget.expiredShop.length < 5 ? widget.expiredShop.length : 5,
        //       //   shrinkWrap: true,
        //       //   physics: const NeverScrollableScrollPhysics(),
        //       //   itemBuilder: (_, i) {
        //       //     return ListTile(
        //       //       contentPadding: EdgeInsets.zero,
        //       //       horizontalTitleGap: 0,
        //       //       title: Text(
        //       //         widget.expiredShop[i].companyName.toString(),
        //       //         style: kTextStyle.copyWith(color: kTitleColor),
        //       //       ),
        //       //       subtitle: Text(
        //       //         widget.expiredShop[i].businessCategory.toString(),
        //       //         style: kTextStyle.copyWith(color: kBlueTextColor),
        //       //       ),
        //       //       trailing: Text(
        //       //         widget.expiredShop[i].subscriptionDate.toString().substring(0, 10),
        //       //         style: kTextStyle.copyWith(color: kGreyTextColor),
        //       //       ),
        //       //     );
        //       //   },
        //       // ),
        //       ),
        // ),
      ],
    );
  }
}

class ExpenseSection extends StatefulWidget {
  const ExpenseSection({
    Key? key,
    required this.totalIncomeCurrentYear,
    required this.totalIncomeCurrentMonths,
    required this.totalIncomeLastMonth,
    required this.allMonthData,
    required this.totalIncomeLastYear,
  }) : super(key: key);

  final double totalIncomeCurrentYear;
  final double totalIncomeLastYear;
  final double totalIncomeCurrentMonths;
  final double totalIncomeLastMonth;
  final List<double> allMonthData;

  @override
  State<ExpenseSection> createState() => _ExpenseSectionState();
}

class _ExpenseSectionState extends State<ExpenseSection> {
  double expensePercent() {
    double percentageChange = 0.0;

    if (widget.totalIncomeLastYear > 0) {
      percentageChange = ((widget.totalIncomeCurrentYear - widget.totalIncomeLastYear) / widget.totalIncomeLastYear) * 100;
    } else if (widget.totalIncomeLastYear < 0) {
      percentageChange = ((widget.totalIncomeCurrentYear - widget.totalIncomeLastYear) / widget.totalIncomeLastYear.abs()) * 100;
    } else if (widget.totalIncomeLastYear == 0) {
      percentageChange = 100.0;
    }

    return percentageChange;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: YearlyInfoWidget(
            title: 'Total Income',
            count: '$currency ${widget.totalIncomeCurrentYear}',
            icon: MdiIcons.ticket,
            percentageColor: expensePercent() >= 0 ? Colors.green : Colors.red,
            iconColor: Colors.blueGrey,
            countPercentage: '${expensePercent().toStringAsFixed(0)}% ',
            lastYear: '$currency ${widget.totalIncomeLastYear.toStringAsFixed(0)}',
            currentYear: '$currency ${widget.totalIncomeCurrentYear.toStringAsFixed(0)}',
            arrowIcon: expensePercent() >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            // Removed .toString()
            arrowIconColor: expensePercent() >= 0 ? Colors.green : Colors.red,
            bgColor: const Color(0xFFDEF5EB),
          ),
        ),
      ],
    );
  }
}

//New registered users

const kTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

class NewRegisteredUser extends StatefulWidget {
  const NewRegisteredUser({Key? key, required this.allDay}) : super(key: key);

  final List<int> allDay;

  @override
  State<NewRegisteredUser> createState() => _NewRegisteredUserState();
}

class _NewRegisteredUserState extends State<NewRegisteredUser> {
  late List<_SalesData> data;

  @override
  void initState() {
    super.initState();
    data = initializeSalesData();
  }

  List<_SalesData> initializeSalesData() {
    return List.generate(
      widget.allDay.length,
      (index) => _SalesData((index + 1).toString(), widget.allDay[index].toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 2.0,
          shadowColor: kGreyTextColor,
          child: Container(
            height: 421,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: kWhiteTextColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: Colors.blue,
                      size: 16,
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      'New Registered Users',
                      style: kTextStyle.copyWith(
                        color: kTitleColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Total New Users current month',
                  style: TextStyle(
                    color: kGreyTextColor,
                  ),
                ),
                const SizedBox(height: 20.0),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  plotAreaBorderColor: Colors.transparent,
                  legend: const Legend(
                    isVisible: true,
                    alignment: ChartAlignment.center,
                    position: LegendPosition.bottom,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    ColumnSeries<_SalesData, String>(
                      legendIconType: LegendIconType.rectangle,
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.month,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'New Registered Users',
                      color: Colors.blue,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                      // Enable data label
                      dataLabelSettings: const DataLabelSettings(isVisible: false),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.month, this.sales);

  final String month;
  final double sales;
}
