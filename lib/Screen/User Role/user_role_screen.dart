import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Provider/seller_info_provider.dart';
import '../../Provider/user_role_provider.dart';
import '../../model/user_role_model.dart';
import '../../model/user_role_under_user_model.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class UserRoleScreen extends StatefulWidget {
  const UserRoleScreen({Key? key}) : super(key: key);

  static const String route = '/user_role';

  @override
  State<UserRoleScreen> createState() => _UserRoleScreenState();
}

class _UserRoleScreenState extends State<UserRoleScreen> {
  List<UserRoleUnderUser> mainShowList = [];
  int counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUserAndRestartApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      drawer: const Drawer(
        child: SideBarWidget(
          index: 7,
          isTab: false,
        ),
      ),
      appBar: const GlobalAppbar(),
      body: Consumer(
        builder: (_, ref, watch) {
          final sellerInfo = ref.watch(sellerInfoProvider);
          final userRole = ref.watch(allAdminUserRoleProvider);
          return sellerInfo.when(data: (sellerInfo) {
            return userRole.when(data: (userRole) {
              if (counter < 1) {
                for (var singleSeller in sellerInfo) {
                  List<UserRoleModel> listData = [];
                  for (var singleUserRole in userRole) {
                    if (singleSeller.userID == singleUserRole.databaseId) {
                      listData.add(singleUserRole);
                    }
                  }
                  listData.isNotEmpty ? mainShowList.add(UserRoleUnderUser(sellerInfoModel: singleSeller, userRoles: listData)) : null;
                }
              }
              counter++;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///__________title & buttons__________________________________________________________
                        Row(
                          children: [
                            Text(
                              'User Role System',
                              style: kTextStyle.copyWith(color: kTitleColor, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            // Row(
                            //   children: [
                            //     GestureDetector(
                            //       onTap: (() => newUserAdd(ref: ref)),
                            //       child: Container(
                            //         padding: const EdgeInsets.all(5.0),
                            //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                            //         child: Column(
                            //           children: [
                            //             Text(
                            //               'Add New User',
                            //               style: kTextStyle.copyWith(color: kWhiteTextColor),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     // const SizedBox(width: 10),
                            //     // GestureDetector(
                            //     //   onTap: (() => newImageUpload(ref: ref)),
                            //     //   child: Container(
                            //     //     padding: const EdgeInsets.all(5.0),
                            //     //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                            //     //     child: Column(
                            //     //       children: [
                            //     //         Text(
                            //     //           'Add New Image',
                            //     //           style: kTextStyle.copyWith(color: kWhiteTextColor),
                            //     //         ),
                            //     //       ],
                            //     //     ),
                            //     //   ),
                            //     // ),
                            //   ],
                            // )
                          ],
                        ),
                        const SizedBox(height: 10.0),

                        // SizedBox(
                        //   width: double.infinity,
                        //   child: DataTable(
                        //     border: TableBorder.all(
                        //       color: kBorderColorTextField,
                        //       borderRadius: BorderRadius.circular(5.0),
                        //     ),
                        //     dividerThickness: 1.0,
                        //     headingRowColor: MaterialStateProperty.all(kDarkWhite),
                        //     showBottomBorder: true,
                        //     headingTextStyle: kTextStyle.copyWith(color: kTitleColor, fontSize: 14.0),
                        //     dataTextStyle: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0),
                        //     horizontalMargin: 20.0,
                        //     columnSpacing: 20.0,
                        //     columns: const [
                        //       DataColumn(
                        //         label: Text('S.L'),
                        //       ),
                        //       DataColumn(
                        //         label: Text('SHOP NAME'),
                        //       ),
                        //       DataColumn(
                        //         label: Text('CATEGORY'),
                        //       ),
                        //       DataColumn(
                        //         label: Text('PHONE'),
                        //       ),
                        //       DataColumn(
                        //         label: Text('EMAIL'),
                        //       ),
                        //       DataColumn(
                        //         label: Text('PACKAGE'),
                        //       ),
                        //       DataColumn(
                        //         label: Text('Number Of Roles'),
                        //       ),
                        //       DataColumn(
                        //         label: Text('ACTION'),
                        //       ),
                        //     ],
                        //     rows: List.generate(
                        //       mainShowList.length,
                        //       (index) => DataRow(
                        //         cells: [
                        //           DataCell(
                        //             Text((index + 1).toString()),
                        //           ),
                        //           DataCell(
                        //             Text(mainShowList[index].sellerInfoModel.companyName ?? ''),
                        //           ),
                        //           DataCell(
                        //             Text(mainShowList[index].sellerInfoModel.businessCategory ?? ''),
                        //           ),
                        //           DataCell(
                        //             Text(mainShowList[index].sellerInfoModel.phoneNumber ?? ''),
                        //           ),
                        //           DataCell(
                        //             Text(mainShowList[index].sellerInfoModel.email ?? ''),
                        //           ),
                        //           DataCell(
                        //             Text(mainShowList[index].sellerInfoModel.subscriptionName ?? ''),
                        //           ),
                        //           DataCell(
                        //             Text(mainShowList[index].userRoles.length.toString()),
                        //           ),
                        //           DataCell(
                        //             PopupMenuButton(
                        //               icon: const Icon(FeatherIcons.moreVertical, size: 18.0),
                        //               padding: EdgeInsets.zero,
                        //               itemBuilder: (BuildContext bc) => [
                        //                 PopupMenuItem(
                        //                   child: GestureDetector(
                        //                     onTap: () => newUserAdd(ref: ref, sellerInfoModel: sellerInfo[index]),
                        //                     child: Row(
                        //                       children: [
                        //                         const Icon(FeatherIcons.eye, size: 18.0, color: kTitleColor),
                        //                         const SizedBox(width: 4.0),
                        //                         Text(
                        //                           'Create User',
                        //                           style: kTextStyle.copyWith(color: kTitleColor),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //               onSelected: (value) {
                        //                 Navigator.pushNamed(context, '$value');
                        //               },
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Container(
                          decoration: const BoxDecoration(color: kLitGreyColor),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                SizedBox(width: 50, child: Text('S.L')),
                                SizedBox(width: 230, child: Text('Shop Name')),
                                SizedBox(width: 180, child: Text('Category')),
                                SizedBox(width: 200, child: Text('Phone')),
                                SizedBox(width: 200, child: Text('Email')),
                                SizedBox(width: 100, child: Text('Number Of Role')),
                              ],
                            ),
                          ),
                        ),

                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: mainShowList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: .5, color: Colors.grey))),
                              child: ExpansionTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 50, child: Text((index + 1).toString())),
                                      SizedBox(width: 230, child: Text(mainShowList[index].sellerInfoModel.companyName.toString())),
                                      SizedBox(width: 180, child: Text(mainShowList[index].sellerInfoModel.businessCategory.toString())),
                                      SizedBox(width: 200, child: Text(mainShowList[index].sellerInfoModel.phoneNumber.toString())),
                                      SizedBox(width: 200, child: Text(mainShowList[index].sellerInfoModel.email.toString())),
                                      SizedBox(width: 50, child: Text(mainShowList[index].userRoles.length.toString())),
                                    ],
                                  ),
                                ),
                                children: List.generate(
                                  mainShowList[index].userRoles.length,
                                  (i) => Padding(
                                    padding: const EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 60),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 50, child: Text((i + 1).toString())),
                                        SizedBox(width: 230, child: Text(mainShowList[index].userRoles[i].userTitle.toString())),
                                        SizedBox(width: 180, child: Text(mainShowList[index].sellerInfoModel.businessCategory.toString())),
                                        SizedBox(width: 200, child: Text(mainShowList[index].sellerInfoModel.phoneNumber.toString())),
                                        SizedBox(width: 200, child: Text(mainShowList[index].userRoles[i].email.toString())),
                                        const SizedBox(width: 50
                                            // child: PopupMenuButton(
                                            //   icon: const Icon(FeatherIcons.moreVertical, size: 18.0),
                                            //   padding: EdgeInsets.zero,
                                            //   itemBuilder: (BuildContext bc) => [
                                            //     PopupMenuItem(
                                            //       child: GestureDetector(
                                            //         onTap: () => newUserAdd(ref: ref, sellerInfoModel: sellerInfo[index]),
                                            //         child: Row(
                                            //           children: [
                                            //             const Icon(FeatherIcons.eye, size: 18.0, color: kTitleColor),
                                            //             const SizedBox(width: 4.0),
                                            //             Text(
                                            //               'Create User',
                                            //               style: kTextStyle.copyWith(color: kTitleColor),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            //   onSelected: (value) {
                                            //     Navigator.pushNamed(context, '$value');
                                            //   },
                                            // ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
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

void signUp({required BuildContext context, required String email, required String password, required WidgetRef ref}) async {
  EasyLoading.show(status: 'Registering....');
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    // ignore: unnecessary_null_comparison
    if (userCredential != null) {
      EasyLoading.showSuccess('Successful');
      // ignore: use_build_context_synchronously

      // ref.refresh(profileDetailsProvider);
      // ref.refresh(customerProvider);
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const ProfileSetup(
      //       loginWithPhone: false,
      //     ),
      //   ),
      // );
    }
  } on FirebaseAuthException catch (e) {
    EasyLoading.showError('Failed with Error');
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The password provided is too weak.'),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The account already exists for that email.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  } catch (e) {
    EasyLoading.showError('Failed with Error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
