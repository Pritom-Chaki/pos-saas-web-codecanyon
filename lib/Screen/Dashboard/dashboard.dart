import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salespro_saas_admin/Provider/seller_info_provider.dart';
import 'package:salespro_saas_admin/Screen/Dashboard/statistics_user_overview.dart';
import 'package:salespro_saas_admin/Screen/Widgets/static_string/static_string.dart';
import 'package:salespro_saas_admin/model/seller_info_model.dart';
import '../../Provider/get_subscription_request_privider.dart';
import '../../model/subscription_request_model.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Table Widgets/Dashboard/dashboard_table.dart';
import '../Widgets/Table Widgets/Total Count/total_count_widget.dart';
import '../Widgets/Topbar/topbar.dart';
import 'package:responsive_framework/responsive_framework.dart' as rf;

class MtDashboard extends StatefulWidget {
  const MtDashboard({Key? key}) : super(key: key);

  static const String route = '/dashBoard';

  @override
  State<MtDashboard> createState() => _MtDashboardState();
}

class _MtDashboardState extends State<MtDashboard> {
  int numberOfFree = 0;
  int numberOfMonthly = 0;
  int numberOfHalfYearly = 0;
  int numberOfYear = 0;
  int numberOfLifetime = 0;
  int newReg = 0;

  void getData() async {
    //var data = await FirebaseDatabase.instance.ref('Admin panel');
  }

  @override
  void initState() {
    getData();
    super.initState();
    checkCurrentUserAndRestartApp();
    for (int i = 0;
        i < DateTime(currentDate.year, currentDate.month + 1, 0).day;
        i++) {
      everyDayOfCurrentMonth.add(0);
    }
    for (int i = 0;
        i < DateTime(currentDate.year, currentDate.month + 1, 0).day;
        i++) {
      everyDay.add(0);
    }
  }

  int i = 0;
  int newUserOfCurrentYear = 0;
  List<double> newUserMonthlyOfCurrentYear = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];

  List<SellerInfoModel> free = [];
  List<SellerInfoModel> monthly = [];
  List<SellerInfoModel> halfYearly = [];
  List<SellerInfoModel> yearly = [];
  List<SellerInfoModel> freeMonth = [];
  List<SellerInfoModel> newUser = [];
  List<SellerInfoModel> newUser30Days = [];
  List<SellerInfoModel> todayRegistration = [];
  List<SellerInfoModel> previousMonthRegistration = [];

  ///____________Incomes___________________________
  List<SubscriptionRequestModel> subOfCurrentYear = [];
  List<SubscriptionRequestModel> subOfCurrentMonth = [];
  List<SubscriptionRequestModel> subOfLastMonth = [];
  List<SubscriptionRequestModel> subOfLastYear = [];
  double totalIncomeOfCurrentYear = 0;
  double totalIncomeOfPreviousYear = 0;
  double totalIncomeOfCurrentMonth = 0;
  List<double> everyMonthOfYear = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> everyDayOfCurrentMonth = [];
  List<int> everyDay = [];
  double totalIncomeOfLastMonth = 0;
  List<SellerInfoModel> shopList = [];

  bool showDrawer = false;

  @override
  Widget build(BuildContext context) {
    i++;
    return Scaffold(
      backgroundColor: kDarkWhite,
      drawer: const Drawer(
        child: SideBarWidget(
          index: 0,
          isTab: false,
        ),
      ),
      appBar: const GlobalAppbar(),
      body: Consumer(
        builder: (_, ref, watch) {
          final sellerInfoData = ref.watch(sellerInfoProvider);
          AsyncValue<List<SellerInfoModel>> infoList =
              ref.watch(sellerInfoProvider);
          AsyncValue<List<SubscriptionRequestModel>> subscriptionData =
              ref.watch(subscriptionRequestProvider);
          return infoList.when(data: (infoList) {
            DateTime t = DateTime.now();
            newUser = [];
            free = [];
            monthly = [];
            halfYearly = [];
            yearly = [];
            freeMonth = [];
            newUser = [];
            newUser30Days = [];
            todayRegistration = [];
            previousMonthRegistration = [];

            for (var element in infoList) {
              if (element.subscriptionName == 'Free') {
                free.add(element);
              } else if (element.subscriptionName == 'Monthly') {
                monthly.add(element);
              } else if (element.subscriptionName == 'Kwa Miezi 6') {
                halfYearly.add(element);
              } else if (element.subscriptionName == 'Yearly') {
                yearly.add(element);
              }
              final subscriptionDate = DateTime.parse(
                  element.userRegistrationDate ??
                      (element.subscriptionDate.toString()));
              if (subscriptionDate.isAfter(sevenDays)) {
                newUser.add(element);
              }
              if (subscriptionDate.isAfter(firstDayOfCurrentYear)) {
                newUserOfCurrentYear++;
                newUserMonthlyOfCurrentYear[subscriptionDate.month - 1]++;
                if (subscriptionDate.isAfter(firstDayOfCurrentMonth)) {
                  newUser30Days.add(element);
                  if (subscriptionDate.difference(t).inHours.abs() <= 24) {
                    newReg++;
                    todayRegistration.add(element);
                  }
                }
                if (subscriptionDate.isAfter(firstDayOfPreviousMonth) &&
                    subscriptionDate.isBefore(firstDayOfCurrentMonth)) {
                  previousMonthRegistration.add(element);
                }
              }
            }

            return subscriptionData.when(data: (paymentData) {
              subOfCurrentYear = [];
              subOfCurrentMonth = [];
              subOfLastMonth = [];
              subOfLastYear = [];
              totalIncomeOfCurrentYear = 0;
              totalIncomeOfPreviousYear = 0;
              totalIncomeOfCurrentMonth = 0;
              everyMonthOfYear = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
              totalIncomeOfLastMonth = 0;
              shopList = [];
              for (var element in paymentData) {
                if (element.status == 'approved') {
                  final subscriptionDate =
                      DateTime.tryParse(element.approvedDate.toString()) ??
                          DateTime.now();

                  if (subscriptionDate.isAfter(firstDayOfCurrentYear)) {
                    totalIncomeOfCurrentYear += element.amount;

                    everyMonthOfYear[subscriptionDate.month - 1] +=
                        element.amount;
                    everyDay[subscriptionDate.day - 1] += element.amount;

                    subOfCurrentYear.add(element);

                    if (subscriptionDate.isAfter(firstDayOfCurrentMonth)) {
                      totalIncomeOfCurrentMonth += element.amount;
                      subOfCurrentMonth.add(element);
                      everyDayOfCurrentMonth[subscriptionDate.day - 1]++;
                    }

                    if (subscriptionDate.isAfter(firstDayOfPreviousMonth) &&
                        subscriptionDate.isBefore(firstDayOfCurrentMonth)) {
                      totalIncomeOfLastMonth += element.amount;
                      subOfLastMonth.add(element);
                    }
                    if (subscriptionDate.isAfter(firstDayOfPreviousYear) &&
                        subscriptionDate.isBefore(firstDayOfCurrentYear)) {
                      totalIncomeOfPreviousYear += element.amount;
                      subOfLastYear.add(element);
                    }
                  }
                }
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Define the crossAxisCount based on screen size using ResponsiveValue
                        final crossAxisCount = rf.ResponsiveValue<int>(
                          context,
                          defaultValue: 1,
                          conditionalValues: [
                            rf.Condition.smallerThan(
                                name: BreakpointName.SM.name, value: 1),
                            rf.Condition.largerThan(
                                name: BreakpointName.XS.name, value: 2),
                            rf.Condition.largerThan(
                                name: BreakpointName.MD.name, value: 5),
                          ],
                        ).value;

                        final kChildAspetRation = rf.ResponsiveValue<double>(
                            context,
                            defaultValue: 3.8,
                            conditionalValues: [
                              const rf.Condition.between(
                                  start: 310, end: 330, value: 3.4),
                              const rf.Condition.between(
                                  start: 331, end: 353, value: 3.5),
                              const rf.Condition.between(
                                  start: 380, end: 400, value: 4),
                              const rf.Condition.between(
                                  start: 401, end: 420, value: 4.3),
                              const rf.Condition.between(
                                  start: 421, end: 450, value: 4.4),
                              const rf.Condition.between(
                                  start: 451, end: 480, value: 4.8),
                              const rf.Condition.between(
                                  start: 481, end: 510, value: 5),
                              const rf.Condition.between(
                                  start: 511, end: 530, value: 5.6),
                              const rf.Condition.between(
                                  start: 531, end: 576, value: 5.8),
                              const rf.Condition.between(
                                  start: 577, end: 600, value: 3.1),
                              const rf.Condition.between(
                                  start: 601, end: 650, value: 3.2),
                              const rf.Condition.between(
                                  start: 651, end: 700, value: 3.5),
                              const rf.Condition.between(
                                  start: 800, end: 900, value: 4.3),
                              const rf.Condition.between(
                                  start: 901, end: 1000, value: 4.8),
                              const rf.Condition.between(
                                  start: 1001, end: 1100, value: 5.5),
                              const rf.Condition.between(
                                  start: 1101, end: 1239, value: 6),
                              const rf.Condition.between(
                                  start: 1240, end: 1730, value: 2.6),
                              // const rf.Condition.between(start: 701, end: 705,value: 3.8),
                            ]).value;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: kChildAspetRation,
                          ),
                          itemCount: 5, // The number of items in your grid
                          itemBuilder: (context, index) {
                            // Return the appropriate TotalCount widget based on index
                            switch (index) {
                              case 0:
                                return TotalCount(
                                  icon: 'images/user.svg',
                                  title: 'Total User',
                                  count: infoList.length.toString(),
                                  backgroundColor: const Color(0xFFDAD4FF),
                                  iconBgColor: const Color(0xFF8424FF),
                                );
                              case 1:
                                return TotalCount(
                                  icon: 'images/new.svg',
                                  title: 'New User',
                                  count: newUser.length.toString(),
                                  backgroundColor: const Color(0xFFFFE4C1),
                                  iconBgColor: const Color(0xFFFFA609),
                                );
                              case 2:
                                return TotalCount(
                                  icon: 'images/free.svg',
                                  title: 'Free Plan User',
                                  count: free.length.toString(),
                                  backgroundColor: const Color(0xFFCFFFCA),
                                  iconBgColor: const Color(0xFF0ED128),
                                );
                              case 3:
                                return TotalCount(
                                  icon: 'images/month.svg',
                                  title: 'Monthly Plan User',
                                  count: monthly.length.toString(),
                                  backgroundColor: const Color(0xFFFFE2EB),
                                  iconBgColor: const Color(0xFFFF2267),
                                );
                              case 4:
                                return TotalCount(
                                  icon: 'images/year.svg',
                                  title: 'Yearly Plan User',
                                  count: yearly.length.toString(),
                                  backgroundColor: Colors.blue.withOpacity(0.1),
                                  iconBgColor: Colors.blue,
                                );
                              default:
                                return Container(); // Fallback in case of an unexpected index
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ///--------------------------------
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final kChildAspectRatio = rf.ResponsiveValue<double>(
                            context,
                            defaultValue: 3.5,
                            conditionalValues: [
                              const rf.Condition.between(start: 310, end: 330, value: 0.75),
                              const rf.Condition.between(start: 331, end: 353, value: 0.79),
                              const rf.Condition.between(start: 354, end: 379, value: 0.85),
                              const rf.Condition.between(start: 380, end: 400, value: 0.92),
                              const rf.Condition.between(start: 401, end: 420, value: 0.98),
                              const rf.Condition.between(start: 421, end: 450, value: 1.03),
                              const rf.Condition.between(start: 451, end: 480, value: 1.11),
                              const rf.Condition.between(start: 481, end: 510, value: 1.2),
                              const rf.Condition.between(start: 511, end: 530, value: 1.28),
                              const rf.Condition.between(start: 531, end: 576, value: 1.32),
                              const rf.Condition.between(start: 577, end: 600, value: 1.45),
                              const rf.Condition.between(start: 601, end: 650, value: 1.52),
                              const rf.Condition.between(start: 651, end: 700, value: 1.62),
                              const rf.Condition.between(start: 701, end: 799, value: 1.8),
                              const rf.Condition.between(start: 800, end: 900, value: 2.05),
                              const rf.Condition.between(start: 901, end: 1000, value: 2.3),
                              const rf.Condition.between(start: 1001, end: 1100, value: 2.6),
                              const rf.Condition.between(start: 1101, end: 1239, value: 2.89),
                              const rf.Condition.between(start: 1240, end: 1340, value: 1.6),
                            ],
                          ).value;
                          final kItemAspectRation = rf.ResponsiveValue<double>(
                            context,
                            defaultValue: 1,
                            conditionalValues: [
                              const rf.Condition.between(start: 310, end: 330, value: 1.85),
                              const rf.Condition.between(start: 331, end: 353, value: 1.94),
                              const rf.Condition.between(start: 354, end: 379, value: 2.05),
                              const rf.Condition.between(start: 380, end: 400, value: 2.25),
                              const rf.Condition.between(start: 401, end: 420, value: 2.4),
                              const rf.Condition.between(start: 421, end: 450, value: 2.54),
                              const rf.Condition.between(start: 451, end: 480, value: 2.74),
                              const rf.Condition.between(start: 481, end: 510, value: 2.94),
                              const rf.Condition.between(start: 511, end: 530, value: 3.14),
                              const rf.Condition.between(start: 531, end: 576, value: 3.27),
                              const rf.Condition.between(start: 577, end: 600, value: 1.7),
                              const rf.Condition.between(start: 601, end: 650, value: 1.82),
                              const rf.Condition.between(start: 651, end: 700, value: 1.99),
                              const rf.Condition.between(start: 701, end: 799, value: 2.17),
                              const rf.Condition.between(start: 800, end: 900, value: 2.5),
                              const rf.Condition.between(start: 901, end: 1000, value: 2.82),
                              const rf.Condition.between(start: 1001, end: 1100, value: 3.1),
                              const rf.Condition.between(start: 1101, end: 1239, value: 3.45),
                              const rf.Condition.between(start: 1240, end: 1340, value: 1.9),
                            ],
                          ).value;
                          final  itemCrossCount= rf.ResponsiveValue<int>(
                            context,
                            defaultValue: 1,
                            conditionalValues: [
                              rf.Condition.smallerThan(
                                  name: BreakpointName.SM.name, value: 1),
                              rf.Condition.largerThan(
                                  name: BreakpointName.XS.name, value: 2),
                            ],
                          ).value;

                          final  mainCrossCount= rf.ResponsiveValue<int>(
                            context,
                            defaultValue: 1,
                            conditionalValues: [
                              rf.Condition.largerThan(
                                  name: BreakpointName.MD.name, value: 2),
                            ],
                          ).value;
                          final  isItem= rf.ResponsiveValue<bool>(
                            context,
                            defaultValue: false,
                            conditionalValues: [
                              rf.Condition.smallerThan(
                                  name: BreakpointName.SM.name, value: true),
                            ],
                          ).value;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: mainCrossCount,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                              childAspectRatio:  kChildAspectRatio,
                            ),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return StatisticsData(
                                  totalIncomeCurrentMonths: totalIncomeOfCurrentMonth,
                                  totalIncomeLastMonth: totalIncomeOfLastMonth,
                                  totalIncomeCurrentYear: totalIncomeOfCurrentYear,
                                  allMonthData: everyMonthOfYear,
                                  allDay: everyDay,
                                  totalUser: double.parse(infoList.length.toString()),
                                  freeUser: double.parse(free.length.toString()),
                                );
                              } else {
                                return SingleChildScrollView(
                                  child: Container(
                                    // padding:  const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(color: kBorderColorTextField.withOpacity(0.1), blurRadius: 4, blurStyle: BlurStyle.inner, spreadRadius: 1, offset: const Offset(0, 1))
                                      ],
                                    ),
                                    child: GridView.builder(
                                      itemCount: 4,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: kItemAspectRation,
                                        crossAxisCount: itemCrossCount,
                                      ),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return TopSellingStore(
                                              newReg1: newUser,
                                              monthlyReg: newUser30Days,
                                              previousReg: previousMonthRegistration,
                                              totalUSer: infoList.length.toString(),
                                            );
                                          case 1:
                                            return Subscribed(
                                              subOfCurrentMonth: subOfCurrentMonth,
                                              subOfCurrentYear: subOfCurrentYear,
                                              subOfLastMonth: subOfLastMonth,
                                              totalNewUserCurrentYear: newUserOfCurrentYear,
                                              userInMonthOfYear: newUserMonthlyOfCurrentYear,
                                            );
                                          case 2:
                                            return IncomeSection(
                                              totalIncomeCurrentMonths: totalIncomeOfCurrentMonth,
                                              totalIncomeLastMonth: totalIncomeOfLastMonth,
                                              totalIncomeCurrentYear: totalIncomeOfCurrentYear,
                                              allMonthData: everyMonthOfYear,
                                            );
                                          case 3:
                                            return ExpenseSection(
                                              totalIncomeCurrentMonths: totalIncomeOfCurrentMonth,
                                              totalIncomeLastMonth: totalIncomeOfLastMonth,
                                              totalIncomeCurrentYear: totalIncomeOfCurrentYear,
                                              allMonthData: everyMonthOfYear,
                                              totalIncomeLastYear: totalIncomeOfPreviousYear,
                                            );
                                          default:
                                            return Container();
                                        }
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    ///----------------------
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 360,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Recently Registered Users',
                                    style: TextStyle(
                                        color: kTitleColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10.0),
                                  sellerInfoData.when(data: (sellerSnap) {
                                    shopList = sellerSnap;
                                    List<SellerInfoModel> lastShopList =
                                        shopList.length > 5
                                            ? shopList
                                                .sublist(shopList.length - 5)
                                            : shopList;
                                    lastShopList =
                                        lastShopList.reversed.toList();
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: DataTable(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        border: TableBorder.all(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kBorderColorTextField),
                                        showCheckboxColumn: true,
                                        dividerThickness: 1.0,
                                        dataRowColor:
                                            const WidgetStatePropertyAll(
                                                Colors.white),
                                        headingRowColor:
                                            WidgetStateProperty.all(
                                                const Color(0xffF8F1FF)),
                                        showBottomBorder: false,
                                        headingTextStyle: const TextStyle(
                                          color: kTitleColor,
                                        ),
                                        dataTextStyle: const TextStyle(
                                            color: Color(0xff525252)),
                                        columns: const [
                                          DataColumn(label: Text('S.L')),
                                          DataColumn(label: Text('Name')),
                                          DataColumn(label: Text('Email')),
                                          DataColumn(
                                              label: Text(
                                            'Subscription Plan',
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                        ],
                                        rows: List.generate(
                                          lastShopList.reversed.toList().length,
                                          (index) => DataRow(
                                            cells: [
                                              DataCell(
                                                Text(
                                                  (index + 1).toString(),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              DataCell(
                                                Text(lastShopList[index]
                                                    .companyName
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(lastShopList[index]
                                                    .email
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(lastShopList[index]
                                                    .subscriptionName
                                                    .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }, error: (e, stack) {
                                    return Center(
                                      child: Text(e.toString()),
                                    );
                                  }, loading: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            flex: 2,
                            child: UserOverView(
                              totalUser: double.parse(
                                infoList.length.toString(),
                              ),
                              freeUser: double.parse(
                                free.length.toString(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }, error: (e, stock) {
              return Center(
                child: Text(e.toString()),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
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
