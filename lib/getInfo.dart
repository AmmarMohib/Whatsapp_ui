// ignore_for_file: unused_local_variable, unused_field, non_constant_identifier_names, unused_import

import 'dart:io';
import 'dart:math';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' as found;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsap_ui/commons/colors.dart';
import 'package:whatsap_ui/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetInfo extends StatefulWidget {
  @override
  _GetInfoState createState() => _GetInfoState();
}

class _GetInfoState extends State<GetInfo> {
  TextEditingController nameController = TextEditingController();
  bool emojiShowing = false;
  String _selectedItem = "";
  File? _imageFile;
  var pathofimg;
  final _picker = ImagePicker();
  var _url;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Profile Info",
                style: TextStyle(color: lightMainColor, fontSize: 23),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          _imageFile != null
                              ? ClipOval(
                                  child: Image.file(
                                    _imageFile!,
                                    width: 160,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 70,
                                  child: Icon(
                                    FontAwesomeIcons.solidUser,
                                    color: Colors.white,
                                    size: 80,
                                  ),
                                  // backgroundColor: Colors.transparent,
                                  backgroundColor:
                                      Color.fromRGBO(228, 230, 232, 1),
                                ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: maincolor,
                                radius: 25,
                                child: InkWell(
                                    onTap: () {
                                      bottomSheet();
                                    },
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    )),
                              )),
                          Text(
                            _selectedItem,
                            style: TextStyle(fontSize: 30),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                            borderSide: BorderSide(color: maincolor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: maincolor)),
                            hintText: 'Your Name',
                            prefix: Padding(
                              padding: EdgeInsets.all(4),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      IconButton(onPressed: () {
                                               setState(() {
                            emojiShowing = !emojiShowing;
                          });
                      }, icon: Icon(Icons.emoji_emotions_outlined))
                    ],
                  ),
                  SizedBox(height: 40,),
                  ElevatedButton(onPressed: sendnme, child: Text("next"), style: ElevatedButton.styleFrom(backgroundColor: maincolor),),
                      Offstage(
              offstage: !emojiShowing,
              child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                    textEditingController: nameController,
                    config: Config(
                      columns: 7,
                      // Issue: https://github.com/flutter/flutter/issues/28894
                      emojiSizeMax: 32 *
                          (found.defaultTargetPlatform ==
                                  TargetPlatform.iOS
                              ? 1.30
                              : 1.0),
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      initCategory: Category.RECENT,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      backspaceColor: Colors.blue,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      replaceEmojiOnLimitExceed: false,
                      noRecents: const Text(
                        'No Recents',
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ),
                      loadingIndicator: const SizedBox.shrink(),
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL,
                      checkPlatformCompatibility: true,
                    ),
                  )),
            ),
                ],
              ),
            )),
      ),
    );
  }

  sendnme() async {
    final firestoreInstance = FirebaseFirestore.instance;
    if (_url == null) {
      Fluttertoast.showToast(msg: 'wait for uploading image, then retry');
    } else {
      firestoreInstance.collection("numbers&avatars").add({
        "num": FirebaseAuth.instance.currentUser!.phoneNumber,
        "avatar": _url,
        "name": nameController.text,
        "Uid": FirebaseAuth.instance.currentUser!.uid
      });
      firestoreInstance
          .collection("usersInfo")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "name": nameController.text,
        "phoneNum": FirebaseAuth.instance.currentUser!.phoneNumber,
        "user-img": _url
      }).then((_) {
        print("Success");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      });
    }
  }

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text(
                    "gallery",
                  ),
                  onTap: () => takePhoto(ImageSource.gallery),
                ),
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text(
                    "camera",
                  ),
                  onTap: () => takePhoto(ImageSource.camera),
                )
              ],
            ),
          );
        });
  }

  void takePhoto(ImageSource source) async {
    Navigator.pop(context);
    final PickedFile = await _picker.pickImage(source: source);

    setState(() {
      // ignore: unnecessary_cast
      _imageFile = File(PickedFile!.path);
      pathofimg = PickedFile;
    });
    print(_imageFile!.path);
    if (PickedFile == null) {
      Fluttertoast.showToast(msg: 'please upload user Image');
    } else {
      final FirebaseStorage storage = FirebaseStorage.instance;

      Random rnd = Random();
      final String imgPath = 'imgs/${rnd.nextInt(4000)}';

      TaskSnapshot tasking = await storage.ref(imgPath).putFile(_imageFile!);

//alternative 1
      String url = await storage.ref(imgPath).getDownloadURL();
      print('url1 => $url');
      setState(() {
        _url = url;
      });

//alternative 2
      String url2 = await tasking.ref.getDownloadURL();
      print('url2 => $url2');

      // ignore: unnecessary_null_comparison
      if (url != null) {
        print('uploaded => $url');
      }
    }
  }
}
