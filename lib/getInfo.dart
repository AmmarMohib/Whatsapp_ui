// ignore_for_file: unused_local_variable, unused_field, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class GetInfo extends StatefulWidget {
  @override
  _GetInfoState createState() => _GetInfoState();
}

class _GetInfoState extends State<GetInfo> {
  TextEditingController nameController = TextEditingController();
  String _selectedItem = "";
  late FileImage _imageFile;
  final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text("Info")),
            body: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(),
                SizedBox(),
                Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          maxRadius: 60,
                          child: Icon(
                            Icons.account_circle_rounded,
                            size: 128,
                          ),
                          backgroundColor: Colors.transparent,
                          // backgroundImage: _imageFile==null?:,
                          // foregroundImage: image,
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

  sendnme() {
    final firestoreInstance = FirebaseFirestore.instance;

    firestoreInstance.collection("usersInfo").add({
      "name": nameController.text,
      "phoneNum": FirebaseAuth.instance.currentUser!.phoneNumber
    }).then((_) {
      print("Success");
    });
  }

  void bottomSheet() {
    // return MaterialApp(
    //        home:Scaffold(
    //                     body: Container(
    //     height: 100,
    //     width: MediaQuery.of(context).size.width,
    //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //     child: Column(
    //       children: <Widget>[
    //           Text(
    //             "create profile photo",
    //             style: TextStyle(
    //               fontSize: 20,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Row(
    //             children: <Widget>[
    //               ElevatedButton.icon(
    //                   onPressed: () {},
    //                   icon: Icon(Icons.camera),
    //                   label: Text("gallery")
    //                   ),

    //             ],
    //           )
    //       ],
    //     ),
    //   ),
    //        ),
    // );
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

  // selectedItem() {
  //   Navigator.pop(context);
  // }

  void takePhoto(ImageSource source) async {
    Navigator.pop(context);
    final PickedFile = await _picker.pickImage(source: source);
    final f = await PickedFile!.path;

    setState(() {
      _imageFile = PickedFile as FileImage;
    });
  }
}
