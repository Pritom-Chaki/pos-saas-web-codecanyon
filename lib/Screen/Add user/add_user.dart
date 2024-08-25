import 'dart:convert';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Provider/shop_category_provider.dart';
import '../../Provider/subacription_plan_provider.dart';
import '../../model/personal_information_model.dart';
import '../../model/seller_info_model.dart';
import '../../model/shop_category_model.dart';
import '../../model/subscription_model.dart';
import '../Dashboard/dashboard.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  static const String route = '/add_user';

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  ScrollController mainScroll = ScrollController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool passwordShow = false;
  String? givenPassword;
  String? givenPassword2;
  int opiningBalance = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController shopOpeningBalanceController = TextEditingController();
  DateTime id = DateTime.now();

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate() && givenPassword == givenPassword2) {
      form.save();
      return true;
    }
    return false;
  }

  //__________________________________________________shop_category_______________________________
  ShopCategoryModel? selectedShopCategory;

  DropdownButton<ShopCategoryModel> getShopCategory({required List<ShopCategoryModel> list}) {
    List<DropdownMenuItem<ShopCategoryModel>> dropDownItems = [];
    for (var element in list) {
      dropDownItems.add(DropdownMenuItem(
        value: element,
        child: Text(
          element.categoryName.toString(),
          style: kTextStyle.copyWith(color: kGreyTextColor, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ));
    }

    return DropdownButton(
      icon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: kGreyTextColor,
      ),
      items: dropDownItems,
      hint: const Text('Select Shop Category'),
      value: selectedShopCategory,
      onChanged: (ShopCategoryModel? value) {
        setState(() {
          selectedShopCategory = value;
        });
      },
    );
  }

//____________________________________profile_picture___________
  String profilePicture =
      'https://firebasestorage.googleapis.com/v0/b/maanpos.appspot.com/o/Profile%20Picture%2Fblank-profile-picture-973460_1280.webp?alt=media&token=3578c1e0-7278-4c03-8b56-dd007a9befd3';

  Uint8List? image;

  Future<void> uploadFile() async {
    if (kIsWeb) {
      try {
        Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
        bytesFromPicker != null
            ? EasyLoading.show(
                status: 'Uploading... ',
                dismissOnTap: false,
              )
            : null;
        var snapshot = await FirebaseStorage.instance.ref('Profile Picture/${DateTime.now().millisecondsSinceEpoch}').putData(bytesFromPicker!);
        var url = await snapshot.ref.getDownloadURL();
        EasyLoading.showSuccess('Upload Successful!');
        setState(() {
          image = bytesFromPicker;
          profilePicture = url.toString();
        });
      } on firebase_core.FirebaseException catch (e) {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.code.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      drawer: const Drawer(
        child: SideBarWidget(
          index: 8,
          isTab: false,
        ),
      ),
      appBar: const GlobalAppbar(),
      body: Scrollbar(
        controller: mainScroll,
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final reports = ref.watch(subscriptionPlanProvider);
            AsyncValue<List<ShopCategoryModel>> categoryList = ref.watch(shopCategoryProvider);
            return Container(
              decoration: const BoxDecoration(color: kDarkWhite),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
                      child: reports.when(data: (data) {
                        return Form(
                          key: globalKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///__________title & buttons__________________________________________________________
                              Text(
                                'Add New User',
                                style: kTextStyle.copyWith(color: kTitleColor, fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //_____________________________________Name_and_category__________
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AppTextField(
                                                controller: companyNameController,
                                                showCursor: true,
                                                cursorColor: kTitleColor,
                                                textFieldType: TextFieldType.EMAIL,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Company Name can\'n be empty';
                                                  }
                                                  return null;
                                                },
                                                decoration: kInputDecoration.copyWith(
                                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  labelText: 'Company Name',
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'Enter Name',
                                                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20.0),
                                            Expanded(
                                              child: categoryList.when(
                                                data: (warehouse) {
                                                  return SizedBox(
                                                    height: 55.0,
                                                    child: FormField(
                                                      builder: (FormFieldState<dynamic> field) {
                                                        return InputDecorator(
                                                          decoration: kInputDecoration.copyWith(
                                                            labelText: 'Business Category',
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                          ),
                                                          // child: DropdownButtonHideUnderline(child: getShopCategory(list: warehouse ?? [])),
                                                          child: DropdownButtonHideUnderline(child: getShopCategory(list: warehouse)),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                error: (e, stack) {
                                                  return Center(
                                                    child: Text(
                                                      e.toString(),
                                                    ),
                                                  );
                                                },
                                                loading: () {
                                                  return const Center(
                                                    child: CircularProgressIndicator(),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),

                                        //_____________________________________Email_and_phone__________
                                        const SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                showCursor: true,
                                                cursorColor: kTitleColor,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Email can\'n be empty';
                                                  } else if (!value.contains('@')) {
                                                    return 'Please enter a valid email';
                                                  }
                                                  return null;
                                                },
                                                controller: emailController,
                                                // onChanged: (value) {
                                                //   // auth.email = value;
                                                //
                                                // },
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: kInputDecoration.copyWith(
                                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  labelText: 'Email Address',
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'Enter email address',
                                                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20.0),
                                            Expanded(
                                              child: TextFormField(
                                                controller: phoneController,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Phone number can\'n be empty';
                                                  } else if (value.length < 8) {
                                                    return 'Enter a valid phone number';
                                                  }
                                                  return null;
                                                },
                                                decoration: kInputDecoration.copyWith(
                                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  labelText: 'Phone Number',
                                                  hintText: 'Enter Phone Number',
                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        //_____________________________________openingBalance_and_address__________
                                        const SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AppTextField(
                                                controller: addressController,
                                                showCursor: true,
                                                cursorColor: kTitleColor,
                                                textFieldType: TextFieldType.NAME,
                                                validator: (value) {
                                                  return null;
                                                },
                                                decoration: kInputDecoration.copyWith(
                                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  labelText: 'Address',
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'Enter your shop address',
                                                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20.0),
                                            Expanded(
                                              child: AppTextField(
                                                controller: shopOpeningBalanceController,
                                                textFieldType: TextFieldType.PHONE,
                                                validator: (value) {
                                                  return null;
                                                },
                                                decoration: kInputDecoration.copyWith(
                                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  labelText: 'Opening Balance',
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'Enter amount',
                                                ),
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                showCursor: true,
                                                cursorColor: kTitleColor,
                                                keyboardType: TextInputType.visiblePassword,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Password can\'t be empty';
                                                  } else if (value.length < 4) {
                                                    return 'Please enter a bigger password';
                                                  } else if (value.length < 4) {
                                                    return 'Please enter a bigger password';
                                                  }
                                                  return null;
                                                },
                                                // onChanged: (value) {
                                                //   auth.password = value;
                                                //   givenPassword = value;
                                                // },
                                                controller: passwordController,
                                                decoration: kInputDecoration.copyWith(
                                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  labelText: 'Password',
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'Enter Password',
                                                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20.0),
                                            Expanded(
                                              child: TextFormField(
                                                showCursor: true,
                                                cursorColor: kTitleColor,
                                                keyboardType: TextInputType.visiblePassword,
                                                // onChanged: (value) {
                                                //   givenPassword2 = value;
                                                // },
                                                controller: confirmPasswordController,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Password can\'t be empty';
                                                  } else if (value.length < 4) {
                                                    return 'Please enter a bigger password';
                                                  } else if (givenPassword != givenPassword2) {
                                                    return 'Password Not mach';
                                                  }
                                                  return null;
                                                },
                                                decoration: kInputDecoration.copyWith(
                                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                  labelText: 'Confirm Password',
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'Enter password again',
                                                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                                  focusColor: kBorderColorTextField,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Container(
                                    width: 1,
                                    height: 280,
                                    decoration: BoxDecoration(color: kBorderColorTextField),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 155,
                                        height: 155,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            DottedBorderWidget(
                                              color: kLitGreyColor,
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                child: Container(
                                                  width: 150,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  child: image != null
                                                      ? InkWell(
                                                          onTap: () => uploadFile(),
                                                          child: Image.memory(
                                                            image!,
                                                            width: 150,
                                                            height: 150,
                                                          ),
                                                        )
                                                      : InkWell(
                                                          onTap: () => uploadFile(),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Icon(
                                                                MdiIcons.image,
                                                                color: kBorderColorTextField,
                                                                size: 100.0,
                                                              ),
                                                              Text(
                                                                'Upload Image',
                                                                style: kTextStyle.copyWith(
                                                                  color: kTitleColor,
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Profile Picture',
                                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 40.0),
                              Center(
                                child: SizedBox(
                                  width: 400,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                      backgroundColor: kMainColor,
                                      textStyle: kTextStyle.copyWith(color: kWhiteTextColor),
                                      shadowColor: kDarkWhite,
                                    ),
                                    onPressed: () async {
                                      EasyLoading.show(status: 'Creating...');
                                      if (selectedShopCategory?.categoryName?.isEmpty ?? true) {
                                        EasyLoading.showError('Please select Business Category');
                                        return;
                                      }

                                      if (!validateAndSave()) {
                                        // Assuming validateAndSave() returns false when validation fails
                                        return;
                                      }

                                      try {
                                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );

                                        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
                                          String userId = FirebaseAuth.instance.currentUser!.uid;
                                          DatabaseReference personalInformationRef =
                                              FirebaseDatabase.instance.ref().child(userId).child('Personal Information');

                                          PersonalInformationModel personalInformation = PersonalInformationModel(
                                            phoneNumber: phoneController.text,
                                            pictureUrl: profilePicture,
                                            companyName: companyNameController.text,
                                            countryName: addressController.text,
                                            language: 'English',
                                            dueInvoiceCounter: 1,
                                            purchaseInvoiceCounter: 1,
                                            saleInvoiceCounter: 1,
                                            businessCategory: selectedShopCategory!.categoryName.toString(),
                                            shopOpeningBalance: shopOpeningBalanceController.text.isEmpty
                                                ? 0
                                                : int.tryParse(shopOpeningBalanceController.text) ?? 0,
                                            remainingShopBalance: shopOpeningBalanceController.text.isEmpty
                                                ? 0
                                                : double.tryParse(shopOpeningBalanceController.text) ?? 0,
                                            currency: '\$',
                                            currentLocale: 'en',
                                          );

                                          await personalInformationRef.set(personalInformation.toJson());

                                          SellerInfoModel sellerInfoModel = SellerInfoModel(
                                            businessCategory: selectedShopCategory!.categoryName.toString(),
                                            companyName: companyNameController.text,
                                            phoneNumber: phoneController.text,
                                            countryName: addressController.text,
                                            language: 'English',
                                            pictureUrl: profilePicture,
                                            userID: userId,
                                            email: FirebaseAuth.instance.currentUser!.email,
                                            subscriptionDate: DateTime.now().toString(),
                                            subscriptionName: 'Free',
                                            subscriptionMethod: 'Not Provided',
                                            userRegistrationDate: DateTime.now().toString(),
                                          );

                                          DatabaseReference productInformationRef =
                                              FirebaseDatabase.instance.ref().child(userId).child('Warehouse List');
                                          WareHouseModel warehouse = WareHouseModel(
                                              warehouseName: 'InHouse', warehouseAddress: companyNameController.text, id: id.toString());
                                          await productInformationRef.push().set(warehouse.toJson());

                                          DatabaseReference sellerListRef =
                                              FirebaseDatabase.instance.ref().child('Admin Panel').child('Seller List');
                                          await sellerListRef.push().set(sellerInfoModel.toJson());

                                          EasyLoading.showSuccess('Added Successfully', duration: const Duration(milliseconds: 1000));

                                          DatabaseReference categoryInformationRef =
                                              FirebaseDatabase.instance.ref().child(userId).child('Categories');
                                          CategoryModel categoryModel = CategoryModel(
                                            categoryName: 'General',
                                            size: false,
                                            color: false,
                                            capacity: false,
                                            type: false,
                                            weight: false,
                                            warranty: false,
                                          );

                                          await categoryInformationRef.push().set(categoryModel.toJson());

                                          SubscriptionModel freeSubscriptionModel = SubscriptionModel(
                                            dueNumber: data.first.dueNumber,
                                            duration: data.first.duration,
                                            partiesNumber: data.first.partiesNumber,
                                            products: data.first.products,
                                            purchaseNumber: data.first.purchaseNumber,
                                            saleNumber: data.first.saleNumber,
                                            subscriptionDate: DateTime.now().toString(),
                                            subscriptionName: 'Free',
                                          );

                                          DatabaseReference subscriptionRef = FirebaseDatabase.instance.ref().child(userId).child('Subscription');
                                          await subscriptionRef.set(freeSubscriptionModel.toJson());

                                          EasyLoading.showSuccess('Added Successfully!');

                                          await FirebaseAuth.instance.signOut();
                                          await Future.delayed(const Duration(seconds: 1));

                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(email: mainLoginEmail, password: mainLoginPassword);
                                          await Future.delayed(const Duration(seconds: 2));
                                          // ref.refresh(sellerInfoProvider);
                                          EasyLoading.showSuccess('Successfully Created');
                                          Navigator.of(context).pushNamed(MtDashboard.route);
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        EasyLoading.showError('Failed with Error: ${e.message}');
                                        if (e.code == 'weak-password') {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text('The password provided is too weak.'),
                                            duration: Duration(seconds: 3),
                                          ));
                                        } else if (e.code == 'email-already-in-use') {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text('The account already exists for that email.'),
                                            duration: Duration(seconds: 3),
                                          ));
                                        }
                                      } catch (e) {
                                        EasyLoading.showError('Failed with Error: $e');
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(e.toString()),
                                          duration: const Duration(seconds: 3),
                                        ));
                                      }
                                    },
                                    child: Text(
                                      'Create',
                                      style: kTextStyle.copyWith(color: kWhiteTextColor, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                      })),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//_____________________________________________warehouse_model_____________________

class WareHouseModel {
  late String warehouseName;
  late String warehouseAddress;
  late String id;

  WareHouseModel({
    required this.warehouseName,
    required this.warehouseAddress,
    required this.id,
  });

  WareHouseModel.fromJson(Map<String, dynamic> json) {
    warehouseName = json['warehouseName'];
    warehouseAddress = json['address'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'warehouseName': warehouseName,
        'address': warehouseAddress,
        'id': id,
      };
}

//_____________________________________________warehouse_provider_____________________

WareHouseRepo warehouse = WareHouseRepo();
final warehouseProvider = FutureProvider.autoDispose<List<WareHouseModel>>((ref) => warehouse.getAllWarehouse());

//_____________________________________________warehouse_repo_____________________

class WareHouseRepo {
  Future<List<WareHouseModel>> getAllWarehouse() async {
    List<WareHouseModel> allWarehouseList = [];

    await FirebaseDatabase.instance.ref(await getUserID()).child('Warehouse List').orderByKey().get().then((value) {
      for (var element in value.children) {
        var data = WareHouseModel.fromJson(jsonDecode(jsonEncode(element.value)));
        allWarehouseList.add(data);
      }
    });
    return allWarehouseList;
  }
}

//______________________categories__

class CategoryModel {
  late String categoryName;
  late bool size;
  late bool color;
  late bool weight;
  late bool capacity;
  late bool type;
  late bool warranty;

  CategoryModel({
    required this.categoryName,
    required this.size,
    required this.color,
    required this.capacity,
    required this.type,
    required this.weight,
    required this.warranty,
  });

  CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    categoryName = json['categoryName'] as String;
    size = json['variationSize'] as bool;
    color = json['variationColor'] as bool;
    capacity = json['variationCapacity'] as bool;
    type = json['variationType'] as bool;
    weight = json['variationWeight'] as bool;
    warranty = json['variationWarranty'] as bool;
  }

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'categoryName': categoryName,
        'variationSize': size,
        'variationColor': color,
        'variationCapacity': capacity,
        'variationType': type,
        'variationWeight': weight,
        'variationWarranty': warranty,
      };
}
