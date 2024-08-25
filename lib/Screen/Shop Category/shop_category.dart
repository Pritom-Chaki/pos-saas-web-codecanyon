import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/Provider/shop_category_provider.dart';
import 'package:salespro_saas_admin/model/shop_category_model.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Constant Data/export_button.dart';
import '../Widgets/Pop Up/Shop Category/edit_category.dart';
import '../Widgets/Pop Up/Shop Category/new_category.dart';
import '../Widgets/Pop Up/Shop Category/view_category.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class ShopCategory extends StatefulWidget {
  const ShopCategory({Key? key}) : super(key: key);

  static const String route = '/shopCategory';

  @override
  State<ShopCategory> createState() => _ShopCategoryState();
}

class _ShopCategoryState extends State<ShopCategory> with TickerProviderStateMixin {
  //Add New Category PopUp
  // void showAddCategoryPopUp() {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         child: const NewCategory(),
  //       );
  //     },
  //   );
  // }

  //VIEW Category PopUp
  void showViewCategoryPopUP(ShopCategoryModel category) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ViewCategory(categoryModel: category),
        );
      },
    );
  }

  void deleteShopCategory({required String categoryName, required WidgetRef updateProduct, required BuildContext context}) async {
    EasyLoading.show(status: 'Deleting..');
    String customerKey = '';

    await FirebaseDatabase.instance.ref('Admin Panel').child('Category').orderByKey().get().then((value) {
      for (var element in value.children) {
        var data = jsonDecode(jsonEncode(element.value));
        if (data['categoryName'].toString() == categoryName) {
          customerKey = element.key.toString();
        }
      }
    });

    DatabaseReference ref = FirebaseDatabase.instance.ref('Admin Panel/Category/$customerKey'); // Remove single quotes here

    await ref.remove();
    // updateProduct.refresh(shopCategoryProvider);
    Navigator.pop(context);
    EasyLoading.showSuccess('Done');
  }

  late TabController controller;
  int activeIndex = 0;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this, initialIndex: activeIndex);
    super.initState();
    checkCurrentUserAndRestartApp();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      drawer: const Drawer(
        child: SideBarWidget(
          index: 2,
          isTab: false,
        ),
      ),
      appBar: const GlobalAppbar(),
      body: Consumer(
        builder: (_, ref, watch) {
          AsyncValue<List<ShopCategoryModel>> categoryList = ref.watch(shopCategoryProvider);
          return categoryList.when(data: (categoryList) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'SHOP LIST',
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: (() => showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  // child:  NewCategory(listOfIncomeCategory: categoryList ?? [],),
                                  child:  NewCategory(listOfIncomeCategory: categoryList,),
                                );
                              },
                            )),
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                              child: Column(
                                children: [
                                  Text(
                                    'ADD NEW CATEGORY',
                                    style: kTextStyle.copyWith(color: kWhiteTextColor),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: kBlueTextColor,
                                    ),
                                    child: const Icon(FeatherIcons.search, color: kWhiteTextColor),
                                  ),
                                ),
                                hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                                contentPadding: const EdgeInsets.all(4.0),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const ExportButton()
                        ],
                      ).visible(false),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          border: TableBorder.all(
                            color: kBorderColorTextField,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          dividerThickness: 1.0,
                          headingRowColor: WidgetStateProperty.all(kDarkWhite),
                          showBottomBorder: true,
                          headingTextStyle: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          dataTextStyle: kTextStyle.copyWith(color: kGreyTextColor),
                          columns: const [
                            DataColumn(
                              label: Text('S.L'),
                            ),
                            DataColumn(
                              label: Text('CATEGORY NAME'),
                            ),
                            DataColumn(
                              label: Text('DESCRIPTION'),
                            ),
                            DataColumn(
                              label: Text('CREATED BY'),
                            ),
                            DataColumn(
                              label: Text('ACTION'),
                            ),
                          ],
                          rows: List.generate(
                            categoryList.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(
                                  Text((index + 1).toString()),
                                ),
                                DataCell(
                                  Text(categoryList[index].categoryName ?? ''),
                                ),
                                DataCell(
                                  Text(categoryList[index].description ?? ''),
                                ),
                                const DataCell(
                                  Text('Admin'),
                                ),
                                DataCell(
                                  PopupMenuButton(
                                    icon: const Icon(FeatherIcons.moreVertical, size: 18.0),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (BuildContext bc) => [
                                      PopupMenuItem(
                                        child: GestureDetector(
                                          onTap: (() => showViewCategoryPopUP(
                                                categoryList[index],
                                              )),
                                          child: Row(
                                            children: [
                                              const Icon(FeatherIcons.eye, size: 18.0, color: kTitleColor),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                'View',
                                                style: kTextStyle.copyWith(color: kTitleColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: GestureDetector(
                                          onTap: (() =>  showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                // child: EditCategory(editCategory: categoryList[index], listOfIncomeCategory: categoryList ?? [],),
                                                child: EditCategory(editCategory: categoryList[index], listOfIncomeCategory: categoryList,),
                                              );
                                            },
                                          )),
                                          child: Row(
                                            children: [
                                              const Icon(FeatherIcons.edit3, size: 18.0, color: kTitleColor),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                'Edit',
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
                                                            const Text(
                                                              'Are you want to delete this Shop Category',
                                                              style: TextStyle(fontSize: 22),
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
                                                                    child: const Center(
                                                                      child: Text(
                                                                        'Cancel',
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
                                                                    child: const Center(
                                                                      child: Text(
                                                                        'Delete',
                                                                        style: TextStyle(color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    deleteShopCategory(
                                                                        categoryName: categoryList[index].categoryName.toString(),
                                                                        updateProduct: ref,
                                                                        context: bc);
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
                                                'Delete',
                                                style: kTextStyle.copyWith(color: kTitleColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                    onSelected: (value) {
                                      Navigator.pushNamed(context, '$value');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
          });
        },
      ),
    );
  }
}
