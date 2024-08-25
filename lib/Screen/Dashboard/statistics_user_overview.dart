import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../currency.dart';
import '../Widgets/Constant Data/constant.dart';

class StatisticsData extends StatefulWidget {
  const StatisticsData(
      {Key? key,
      required this.totalIncomeCurrentYear,
      required this.totalIncomeCurrentMonths,
      required this.totalIncomeLastMonth,
      required this.allMonthData,
      required this.allDay,
      required this.totalUser,
      required this.freeUser})
      : super(key: key);
  final double totalIncomeCurrentYear;
  final double totalIncomeCurrentMonths;
  final double totalIncomeLastMonth;
  final List<double> allMonthData;
  final List<int> allDay;
  final double totalUser;
  final double freeUser;

  @override
  State<StatisticsData> createState() => _StatisticsDataState();
}

class _StatisticsDataState extends State<StatisticsData> {
  List<MonthlyIncomeData> data = [
    MonthlyIncomeData('Jan', 0),
    MonthlyIncomeData('Feb', 0),
    MonthlyIncomeData('Mar', 0),
    MonthlyIncomeData('Apr', 0),
    MonthlyIncomeData('May', 0),
    MonthlyIncomeData('Jun', 0),
    MonthlyIncomeData('July', 0),
    MonthlyIncomeData('Aug', 0),
    MonthlyIncomeData('Sep', 0),
    MonthlyIncomeData('Oct', 0),
    MonthlyIncomeData('Nov', 0),
    MonthlyIncomeData('Dec', 0),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [
      MonthlyIncomeData('Jan', widget.allMonthData[0]),
      MonthlyIncomeData('Feb', widget.allMonthData[1]),
      MonthlyIncomeData('Mar', widget.allMonthData[2]),
      MonthlyIncomeData('Apr', widget.allMonthData[3]),
      MonthlyIncomeData('May', widget.allMonthData[4]),
      MonthlyIncomeData('Jun', widget.allMonthData[5]),
      MonthlyIncomeData('Jul', widget.allMonthData[6]),
      MonthlyIncomeData('Aug', widget.allMonthData[7]),
      MonthlyIncomeData('Sep', widget.allMonthData[8]),
      MonthlyIncomeData('Oct', widget.allMonthData[9]),
      MonthlyIncomeData('Nov', widget.allMonthData[10]),
      MonthlyIncomeData('Dec', widget.allMonthData[11]),
    ];
    dailyData = initializeSalesData();
  }

  List<String> monthList = [
    'Monthly',
    'Yearly',
  ];

  String selectedMonth = 'Yearly';

  DropdownButton<String> getCategories() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in monthList) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(
          des,
          style: const TextStyle(color: kTitleColor, fontWeight: FontWeight.normal, fontSize: 14),
        ),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(Icons.keyboard_arrow_down),
      padding: EdgeInsets.zero,
      items: dropDownItems,
      value: selectedMonth,
      onChanged: (value) {
        setState(() {
          selectedMonth = value!;
        });
      },
    );
  }

  final ScrollController stockInventoryScrollController = ScrollController();

  late List<DailyIncomeData> dailyData;

  List<DailyIncomeData> initializeSalesData() {
    return List.generate(
      widget.allDay.length,
      (index) => DailyIncomeData((index + 1).toString(), widget.allDay[index].toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double percentageChange = 0.0;
    double freePercentage = ((widget.freeUser * 100) / widget.totalUser);
    double paidPercentage = 100 - freePercentage;
    print(freePercentage);
    print(paidPercentage);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //________________________________________________Statistics______
        Expanded(
          flex: 2,
          child: Container(
            // height:380,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: kBorderColorTextField.withOpacity(0.1), blurRadius: 4, blurStyle: BlurStyle.inner, spreadRadius: 1, offset: const Offset(0, 1))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15.0),
                  child: Row(
                    children: [
                      Text(
                        'Statistic (Total income)',
                        style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: kTitleColor),
                      ),
                      const Spacer(),
                      Container(
                        height: 36,
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: kBorderColorTextField),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: getCategories(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: kBorderColorTextField,
                  thickness: 1.0,
                ),
                Visibility(
                  visible: selectedMonth == 'Yearly',
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SfCartesianChart(
                      borderWidth: 1.0,
                      backgroundColor: Colors.white,
                      borderColor: Colors.transparent,
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                      ),
                      plotAreaBorderColor: Colors.transparent,
                      legend: const Legend(
                        isVisible: true,
                        alignment: ChartAlignment.center,
                        position: LegendPosition.top,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<MonthlyIncomeData, String>>[
                        SplineSeries<MonthlyIncomeData, String>(
                          splineType: SplineType.natural,
                          legendIconType: LegendIconType.circle,
                          dataSource: data,
                          xValueMapper: (MonthlyIncomeData sales, _) => sales.month,
                          yValueMapper: (MonthlyIncomeData sales, _) => sales.sales,
                          name: 'Total income:$currency${widget.totalIncomeCurrentYear}',
                          color: kMainColor,
                          enableTooltip: true,
                          // borderRadius: const BorderRadius.only(
                          //   topRight: Radius.circular(30.0),
                          //   topLeft: Radius.circular(30.0),
                          // ),
                          // Enable data label
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: selectedMonth == 'Monthly',
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SfCartesianChart(
                      borderWidth: 1.0,
                      backgroundColor: Colors.white,
                      borderColor: Colors.transparent,
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                      ),
                      plotAreaBorderColor: Colors.transparent,
                      legend: const Legend(
                        isVisible: true,
                        alignment: ChartAlignment.center,
                        position: LegendPosition.top,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<DailyIncomeData, String>>[
                        SplineSeries<DailyIncomeData, String>(
                          splineType: SplineType.natural,
                          legendIconType: LegendIconType.circle,
                          dataSource: dailyData,
                          xValueMapper: (DailyIncomeData sales, _) => sales.day,
                          yValueMapper: (DailyIncomeData sales, _) => sales.sales,
                          name: 'Total income:$currency${widget.totalIncomeCurrentYear}',
                          color: kMainColor,
                          enableTooltip: true,
                          // borderRadius: const BorderRadius.only(
                          //   topRight: Radius.circular(30.0),
                          //   topLeft: Radius.circular(30.0),
                          // ),
                          // Enable data label
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class UserOverView extends StatefulWidget {
  const UserOverView({super.key, required this.totalUser, required this.freeUser});
  final double totalUser;
  final double freeUser;

  @override
  State<UserOverView> createState() => _UserOverViewState();
}


class _UserOverViewState extends State<UserOverView> {


  @override
  Widget build(BuildContext context) {
    double freePercentage = ((widget.freeUser * 100) / widget.totalUser);
    double paidPercentage = 100 - freePercentage;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: kBorderColorTextField.withOpacity(0.1),
            blurRadius: 4,
            blurStyle: BlurStyle.inner,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'User overview',
            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
          ),
          const Divider(
            thickness: 1.0,
            color: kBorderColorTextField,
          ),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 213,
                  height: 213,
                  child: PieChart(
                    PieChartData(
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 70,
                      pieTouchData: PieTouchData(),
                      sections: [
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.green,
                          value: freePercentage,
                          title: '40%',
                          radius: 40,
                          titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: kBlueTextColor,
                          value: paidPercentage,
                          title: '30%',
                          radius: 40,
                          titleStyle: const TextStyle(fontSize: 16, color: Color(0xffffffff)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Indicator(
                      size: 12,
                      color: Colors.green,
                      text: 'Free: ',
                      isSquare: false,
                      percent: '${freePercentage.toStringAsFixed(2)}%',
                    ),
                    const SizedBox(height: 20),
                    Indicator(
                      size: 12,
                      color: kBlueTextColor,
                      text: 'Premium: ',
                      isSquare: false,
                      percent: '${paidPercentage.toStringAsFixed(2)}%',
                    ),
                  ],
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
}


class MonthlyIncomeData {
  MonthlyIncomeData(this.month, this.sales);

  final String month;
  final double sales;
}

class DailyIncomeData {
  DailyIncomeData(this.day, this.sales);

  final String day;
  final double sales;
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.percent,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final String percent;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        RichText(
          text: TextSpan(
              text: text,
              style: const TextStyle(
                color: kGreyTextColor,
              ),
              children: [
                TextSpan(
                  text: percent,
                  style: const TextStyle(
                    color: kTitleColor,
                  ),
                )
              ]),
        ),
      ],
    );
  }
}
