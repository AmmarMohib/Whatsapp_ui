// ignore_for_file: unused_local_variable, unused_field, non_constant_identifier_names, unused_import

import 'dart:io';
import 'dart:math';

import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsap_ui/home.dart';

class GetInfo extends StatefulWidget {
  @override
  _GetInfoState createState() => _GetInfoState();
}

class _GetInfoState extends State<GetInfo> {
  TextEditingController nameController = TextEditingController();
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
            appBar: AppBar(title: Text("Info")),
            body: Column(
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
                                maxRadius: 60,
                                child: Icon(
                                  Icons.account_circle_rounded,
                                  size: 128,
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                        Positioned(
                            bottom: 15,
                            right: 20,
                            child: InkWell(
                                onTap: () {
                                  bottomSheet();
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.blueAccent,
                                ))),
                        Text(
                          _selectedItem,
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    )
                  ],
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Display Name',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
                ElevatedButton(onPressed: sendnme, child: Text("next"))
              ],
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
        "num" : FirebaseAuth.instance.currentUser!.phoneNumber,
        "avatar" : _url,
        "name" : nameController.text,
        "Uid" : FirebaseAuth.instance.currentUser!.uid
      });
      firestoreInstance.collection("usersInfo").doc(FirebaseAuth.instance.currentUser!.uid).set({
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
          return Column(
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
    }
    else{
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
