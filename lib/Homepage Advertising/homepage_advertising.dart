// ignore_for_file: unused_result

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/model/homepage_image_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Provider/homepage_image_provider.dart';
import '../Screen/Widgets/Constant Data/constant.dart';
import '../Screen/Widgets/Sidebar/sidebar_widget.dart';
import '../Screen/Widgets/Topbar/topbar.dart';

class HomepageAdvertising extends StatefulWidget {
  const HomepageAdvertising({Key? key}) : super(key: key);

  static const String route = '/homepage_advertising';

  @override
  State<HomepageAdvertising> createState() => _HomepageAdvertisingState();
}

class _HomepageAdvertisingState extends State<HomepageAdvertising> {
  void newVideoAdd({required WidgetRef ref}) {
    String videoLink = '';
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        videoLink = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'YouTube Video Id',
                        hintText: 'Enter Youtube Video Id',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (() => Navigator.pop(context)),
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                            child: Column(
                              children: [
                                Text(
                                  'Cancel',
                                  style: kTextStyle.copyWith(color: kWhiteTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () async {
                            if (videoLink != '') {
                              EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                              HomePageAdvertisingModel data = HomePageAdvertisingModel(imageUrl: videoLink);
                              final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Homepage Image');
                              await adRef.push().set(data.toJson());
                              EasyLoading.showSuccess('Added Successfully', duration: const Duration(milliseconds: 500));

                              ///____provider_refresh____________________________________________
                              ref.refresh(homepageAdvertising);

                              Future.delayed(const Duration(milliseconds: 100), () {
                                Navigator.pop(context);
                              });
                            } else {
                              EasyLoading.showError('Please Enter Video Id');
                            }
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                            child: Column(
                              children: [
                                Text(
                                  'Save',
                                  style: kTextStyle.copyWith(color: kWhiteTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  void newImageUpload({required WidgetRef ref}) {
    String imageUrl = '';

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState1) {
          Future<void> uploadFile() async {
            if (kIsWeb) {
              try {
                Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                if (bytesFromPicker!.isNotEmpty) {
                  EasyLoading.show(
                    status: 'Uploading... ',
                    dismissOnTap: false,
                  );
                }

                var snapshot = await FirebaseStorage.instance.ref('Homepage Advertising Storage/${DateTime.now().millisecondsSinceEpoch}').putData(bytesFromPicker);
                var url = await snapshot.ref.getDownloadURL();
                EasyLoading.showSuccess('Upload Successful!');
                setState1(() {
                  imageUrl = url.toString();
                });
              } on FirebaseException catch (e) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code.toString())));
              }
            }
          }

          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10.0),
                              DottedBorderWidget(
                                padding: const EdgeInsets.all(6),
                                color: kLitGreyColor,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    width: context.width(),
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(MdiIcons.cloudUpload, size: 50.0, color: kLitGreyColor).onTap(() => uploadFile()),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Upload an image',
                                            style: kTextStyle.copyWith(color: kGreenTextColor, fontWeight: FontWeight.bold),
                                            children: [
                                              TextSpan(
                                                text: ' or drag & drop PNG, JPG',
                                                style: kTextStyle.copyWith(color: kGreyTextColor, fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              imageUrl == ''
                                  ? Container(
                                      decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
                                      height: 150,
                                      width: 150,
                                      child: const Center(child: Text('No Image')),
                                    )
                                  : Image.network(
                                      imageUrl,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (() => Navigator.pop(context)),
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                              child: Column(
                                children: [
                                  Text(
                                    'Cancel',
                                    style: kTextStyle.copyWith(color: kWhiteTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () async {
                              if (imageUrl != '') {
                                EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                HomePageAdvertisingModel data = HomePageAdvertisingModel(imageUrl: imageUrl);
                                final DatabaseReference adRef = FirebaseDatabase.instance.ref().child('Admin Panel').child('Homepage Image');
                                await adRef.push().set(data.toJson());
                                EasyLoading.showSuccess('Added Successfully', duration: const Duration(milliseconds: 500));

                                ///____provider_refresh____________________________________________
                                ref.refresh(homepageAdvertising);

                                Future.delayed(const Duration(milliseconds: 100), () {
                                  Navigator.pop(context);
                                });
                              } else {
                                EasyLoading.showError('Please Upload a Image');
                              }
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                              child: Column(
                                children: [
                                  Text(
                                    'Save',
                                    style: kTextStyle.copyWith(color: kWhiteTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
      },
    );
  }

  Future<void> deleteUrl({required WidgetRef updateRef, required String url}) async {
    if (!isDemo) {
      EasyLoading.show(status: 'Deleting..');
      String imageKey = '';
      await FirebaseDatabase.instance.ref().child('Admin Panel').child('Homepage Image').orderByKey().get().then((value) async {
        for (var element in value.children) {
          var data = jsonDecode(jsonEncode(element.value));
          if (data['imageUrl'].toString() == url) {
            imageKey = element.key.toString();
          }
        }
      });
      DatabaseReference ref = FirebaseDatabase.instance.ref("Admin Panel/Homepage Image/$imageKey");
      await ref.remove();
      updateRef.refresh(homepageAdvertising);

      EasyLoading.showSuccess('Done');
    } else {
      EasyLoading.showInfo(demoText);
    }
  }

  void editAdvertisingVideo({required WidgetRef updateRef, required String url}) {
    String videoLink = '';
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: url,
                      onChanged: (value) {
                        videoLink = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'YouTube Video Id',
                        hintText: 'Enter Youtube Video Id',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (() => Navigator.pop(context)),
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                            child: Column(
                              children: [
                                Text(
                                  'Cancel',
                                  style: kTextStyle.copyWith(color: kWhiteTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () async {
                            if (!isDemo) {
                              if (videoLink != '') {
                                EasyLoading.show(status: 'Editing');
                                String imageKey = '';
                                await FirebaseDatabase.instance.ref().child('Admin Panel').child('Homepage Image').orderByKey().get().then((value) async {
                                  for (var element in value.children) {
                                    var data = jsonDecode(jsonEncode(element.value));
                                    if (data['imageUrl'].toString() == url) {
                                      imageKey = element.key.toString();
                                    }
                                  }
                                });
                                DatabaseReference ref = FirebaseDatabase.instance.ref("Admin Panel/Homepage Image/$imageKey");
                                await ref.update({
                                  'imageUrl': videoLink,
                                });
                                EasyLoading.showSuccess('Added Successfully!');
                                updateRef.refresh(homepageAdvertising);
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              } else {
                                EasyLoading.showError('Please Enter Video Id');
                              }
                            } else {
                              EasyLoading.showInfo(demoText);
                            }
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                            child: Column(
                              children: [
                                Text(
                                  'Save',
                                  style: kTextStyle.copyWith(color: kWhiteTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  void editAdvertisingImage({required WidgetRef updateRef, required String url}) {
    String imageUrl = url;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState1) {
          Future<void> uploadFile() async {
            if (kIsWeb) {
              try {
                Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                if (bytesFromPicker!.isNotEmpty) {
                  EasyLoading.show(
                    status: 'Uploading... ',
                    dismissOnTap: false,
                  );
                }

                var snapshot = await FirebaseStorage.instance.ref('Homepage Advertising Storage/${DateTime.now().millisecondsSinceEpoch}').putData(bytesFromPicker);
                var url = await snapshot.ref.getDownloadURL();
                EasyLoading.showSuccess('Upload Successful!');
                setState1(() {
                  imageUrl = url.toString();
                });
              } on FirebaseException catch (e) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code.toString())));
              }
            }
          }

          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10.0),
                              DottedBorderWidget(
                                padding: const EdgeInsets.all(6),
                                color: kLitGreyColor,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    width: context.width(),
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(MdiIcons.cloudUpload, size: 50.0, color: kLitGreyColor).onTap(() => uploadFile()),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Upload an image',
                                            style: kTextStyle.copyWith(color: kGreenTextColor, fontWeight: FontWeight.bold),
                                            children: [
                                              TextSpan(
                                                text: ' or drag & drop PNG, JPG',
                                                style: kTextStyle.copyWith(color: kGreyTextColor, fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              imageUrl == ''
                                  ? Container(
                                      decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
                                      height: 150,
                                      width: 150,
                                      child: const Center(child: Text('No Image')),
                                    )
                                  : Image.network(
                                      imageUrl,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (() => Navigator.pop(context)),
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.red),
                              child: Column(
                                children: [
                                  Text(
                                    'Cancel',
                                    style: kTextStyle.copyWith(color: kWhiteTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () async {
                              if (!isDemo) {
                                if (imageUrl != '') {
                                  EasyLoading.show(status: 'Editing');
                                  String imageKey = '';
                                  await FirebaseDatabase.instance.ref().child('Admin Panel').child('Homepage Image').orderByKey().get().then((value) async {
                                    for (var element in value.children) {
                                      var data = jsonDecode(jsonEncode(element.value));
                                      if (data['imageUrl'].toString() == url) {
                                        imageKey = element.key.toString();
                                      }
                                    }
                                  });
                                  DatabaseReference ref = FirebaseDatabase.instance.ref("Admin Panel/Homepage Image/$imageKey");
                                  await ref.update({
                                    'imageUrl': imageUrl,
                                  });
                                  EasyLoading.showSuccess('Added Successfully!');

                                  ///____provider_refresh____________________________________________
                                  updateRef.refresh(homepageAdvertising);

                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  EasyLoading.showError('Please Upload a Image');
                                }
                              } else {
                                EasyLoading.showInfo(demoText);
                              }
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                              child: Column(
                                children: [
                                  Text(
                                    'Save',
                                    style: kTextStyle.copyWith(color: kWhiteTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      appBar: const GlobalAppbar(),
      drawer: const Drawer(
        child: SideBarWidget(
          index: 6,
          isTab: false,
        ),
      ),
      body: Consumer(
        builder: (_, ref, watch) {
          final data = ref.watch(homepageAdvertising);
          return data.when(data: (homepageAd) {
            return SingleChildScrollView(
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
                            'Homepage Advertising',
                            style: kTextStyle.copyWith(color: kTitleColor, fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (() => newVideoAdd(ref: ref)),
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Add New Video',
                                        style: kTextStyle.copyWith(color: kWhiteTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: (() => newImageUpload(ref: ref)),
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Add New Image',
                                        style: kTextStyle.copyWith(color: kWhiteTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 10.0),
                      const Divider(height: 1, color: Colors.black12),

                      const SizedBox(height: 10.0),

                      Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: homepageAd.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (homepageAd[index].imageUrl.contains('https://firebasestorage.googleapis.com')) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${index + 1}.'),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: SizedBox(
                                        height: 120,
                                        width: 200,
                                        child: Image(
                                          image: NetworkImage(
                                            homepageAd[index].imageUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                          ),
                                          onPressed: () {
                                            editAdvertisingImage(
                                              url: homepageAd[index].imageUrl,
                                              updateRef: ref,
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
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
                                                              'Are you want to delete this advertising?',
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
                                                                    deleteUrl(updateRef: ref, url: homepageAd[index].imageUrl);
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
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                YoutubePlayerController videoController = YoutubePlayerController(
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: false,
                                  ),
                                  initialVideoId: homepageAd[index].imageUrl,
                                );
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${index + 1}.'),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: SizedBox(
                                        height: 120,
                                        width: 200,
                                        child: YoutubePlayer(
                                          controller: videoController,
                                          showVideoProgressIndicator: true,
                                          onReady: () {},
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                          ),
                                          onPressed: () {
                                            editAdvertisingVideo(
                                              url: homepageAd[index].imageUrl,
                                              updateRef: ref,
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
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
                                                              'Are you want to delete this advertising?',
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
                                                                    deleteUrl(updateRef: ref, url: homepageAd[index].imageUrl);
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
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
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
