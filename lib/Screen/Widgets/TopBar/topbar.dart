import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Authentication/log_in.dart';
import '../Constant Data/constant.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key, this.drawers});
  final Widget ? drawers;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String? dropdownValue = 'Tsh (TZ Shillings)';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrency();
  }

  // getCurrency() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? data = prefs.getString('currency');
  //
  //   if (!data.isEmptyOrNull) {
  //     for (var element in items) {
  //       if (element.substring(0, 2).contains(data!)) {
  //         setState(() {
  //           dropdownValue = element;
  //         });
  //         break;
  //       }
  //     }
  //   } else {
  //     setState(() {
  //       dropdownValue = items[0];
  //     });
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(child: widget.drawers,),
        const Spacer(),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * .25,
          child: TextField(
            showCursor: true,
            cursorColor: kTitleColor,
            decoration: kInputDecoration.copyWith(
              hintText: 'Search Anything...',
              suffixIcon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kBlueTextColor,
                  ),
                  child: const Icon(FeatherIcons.search, color: kWhiteTextColor),
                ),
              ),
              hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
              contentPadding: const EdgeInsets.all(4.0),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                borderSide: BorderSide(color: kBorderColorTextField, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: kBorderColorTextField, width: 2),
              ),
            ),
          ),
        ).visible(false),
        const Spacer(),
        Icon(MdiIcons.bellOutline, color: kTitleColor).visible(false),
        // SizedBox(
        //   width: 340,
        //   child: ListTile(
        //     horizontalTitleGap: 5,
        //     visualDensity: const VisualDensity(horizontal: -4),
        //     title: Text(
        //       'Currency',
        //       style: GoogleFonts.poppins(
        //         color: Colors.black,
        //         fontSize: 18.0,
        //       ),
        //     ),
        //     leading: const Icon(
        //       Icons.currency_exchange,
        //       color: kMainColor,
        //     ),
        //     trailing: DropdownButton(
        //       underline: const SizedBox(),
        //       value: dropdownValue,
        //       icon: const Icon(Icons.keyboard_arrow_down),
        //       items: items.map((String items) {
        //         return DropdownMenuItem(
        //           value: items,
        //           child: Text(items),
        //         );
        //       }).toList(),
        //       onChanged: (newValue) async {
        //         final prefs = await SharedPreferences.getInstance();
        //         if (newValue == '\$ (US Dollar)') {
        //           currency = '\$';
        //           await prefs.setString('currency', currency);
        //         } else {
        //           currency = "Tsh";
        //           await prefs.setString('currency', currency);
        //         }
        //         setState(() {
        //           dropdownValue = newValue.toString();
        //           Navigator.pushReplacement(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => const MtDashboard(),
        //               ));
        //           // Navigator.of(context).pushNamedR(MtHomeScreen.route);
        //         });
        //       },
        //     ),
        //   ),
        // ),
        const SizedBox(width: 10.0),
        PopupMenuButton(
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext bc) => [
            PopupMenuItem(
              child: Text(
                'English',
                style: kTextStyle.copyWith(color: kTitleColor),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Bangla',
                style: kTextStyle.copyWith(color: kTitleColor),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Hindi',
                style: kTextStyle.copyWith(color: kTitleColor),
              ),
            ),
          ],
          onSelected: (value) {
            Navigator.pushNamed(context, '$value');
          },
          child: Container(
            height: 25,
            width: 25,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('images/eng.png'), fit: BoxFit.cover),
            ),
          ),
        ).visible(false),
        const SizedBox(width: 5.0),

        ///________buttons_________________________________________
        Row(
          children: [
            ///_____________change_password_________________________________________________
            PopupMenuButton(
              icon: const Icon(
                FeatherIcons.settings,
                size: 24.0,
                color: kBlueTextColor,
              ),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext bc) => [
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: (() {
                      changePassword(mainContext: context, manuContext: bc);
                    }),
                    child: Text(
                      'Change Password',
                      style: kTextStyle.copyWith(color: kTitleColor),
                    ),
                  ),
                ),
              ],
              onSelected: (value) {
                Navigator.pushNamed(context, '$value');
              },
            ),
            const SizedBox(width: 8.0),

            ///_____________Log_Out__________________________________________________________
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: kBlueTextColor.withOpacity(0.1),
              ),
              child: const Icon(FeatherIcons.logOut, color: kBlueTextColor),
            ).onTap(() async {
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              const LogIn().launch(context, isNewTask: true);
            }),
            const SizedBox(width: 10.0),
          ],
        ),
      ],
    );
  }
}


///------------------------top appbar -------------------------------------
class GlobalAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GlobalAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      actions: [
        PopupMenuButton(
          icon: const Icon(
            FeatherIcons.settings,
            size: 24.0,
            color: kBlueTextColor,
          ),
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext bc) => [
            PopupMenuItem(
              child: GestureDetector(
                onTap: (() {
                  changePassword(mainContext: context, manuContext: bc);
                }),
                child: const Text(
                  'Change Password',
                ),
              ),
            ),
          ],
          onSelected: (value) {
            Navigator.pushNamed(context, '$value');
          },
        ),
        const SizedBox(width: 8.0),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: kBlueTextColor.withOpacity(0.1),
          ),
          child: const Icon(FeatherIcons.logOut, color: kBlueTextColor),
        ).onTap(() async {
          await FirebaseAuth.instance.signOut();
          // ignore: use_build_context_synchronously
          const LogIn().launch(context, isNewTask: true);
        }),
      ],
    );
  }
  @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  Size get preferredSize=>const Size.fromHeight(kToolbarHeight);
}


///------------------------top appbar--------------------------------------

void changePassword({required BuildContext mainContext, required BuildContext manuContext}) {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController conformNewPasswordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  showDialog(
    barrierDismissible: false,
    context: mainContext,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            AppTextField(
                              controller: currentPasswordController,
                              showCursor: true,
                              cursorColor: kTitleColor,
                              textFieldType: TextFieldType.PASSWORD,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Old Password can\'n be empty';
                                } else if (value.length < 6) {
                                  return 'password must be at least 6 characters';
                                }
                                return null;
                              },
                              decoration: kInputDecoration.copyWith(
                                errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                labelText: 'Old Password',
                                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                hintText: 'Enter your Old Password',
                                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            AppTextField(
                              controller: newPasswordController,
                              showCursor: true,
                              cursorColor: kTitleColor,
                              textFieldType: TextFieldType.PASSWORD,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'New Password can\'n be empty';
                                } else if (value.length < 6) {
                                  return 'password must be at least 6 characters';
                                } else if (newPasswordController.text != conformNewPasswordController.text) {
                                  return 'password do not match';
                                }
                                return null;
                              },
                              decoration: kInputDecoration.copyWith(
                                errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                labelText: 'New Password',
                                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                hintText: 'Enter your New Password',
                                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            AppTextField(
                              controller: conformNewPasswordController,
                              showCursor: true,
                              cursorColor: kTitleColor,
                              textFieldType: TextFieldType.PASSWORD,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm Password can\'n be empty';
                                } else if (value.length < 6) {
                                  return 'password must be at least 6 characters';
                                } else if (newPasswordController.text != conformNewPasswordController.text) {
                                  return 'password do not match';
                                }
                                return null;
                              },
                              decoration: kInputDecoration.copyWith(
                                errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                labelText: 'Confirm New Password',
                                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                hintText: 'Enter your Confirm New Password',
                                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pop(manuContext);
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.red),
                              child: const Center(
                                  child: Text(
                                'Cancel',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (validateAndSave()) {
                                EasyLoading.show(status: 'Loading');
                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: kAdminEmail, password: currentPasswordController.text);
                                  if (userCredential.user != null) {
                                    try {
                                      await currentUser!.updatePassword(newPasswordController.text);
                                      EasyLoading.showSuccess('Successful');
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(manuContext);
                                    } catch (e) {
                                      EasyLoading.showError('Error');
                                    }
                                  }
                                } catch (e) {
                                  if (e.toString().contains('The password is invalid or the user does not have a password.')) {
                                    EasyLoading.showError('Current Password is invalid');
                                  }
                                }

                                // if (userCredential.user != null) {
                                //   await currentUser!.updatePassword(newPasswordController.text);
                                //
                                //   EasyLoading.showSuccess('Successful');
                                //
                                //   // ignore: use_build_context_synchronously
                                //   Navigator.pop(context);
                                // } else {
                                //   EasyLoading.showError('Error');
                                // }
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: kGreenTextColor),
                              child: const Center(
                                  child: Text(
                                'Change Password',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
