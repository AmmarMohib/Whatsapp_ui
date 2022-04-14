// ignore_for_file: await_only_futures, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsap_ui/home.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var data;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //   if (data == null) {
    //     print("object");
    //   } else {
    //     print(data);
    //   }
    //   return MaterialApp(
    //       home: Scaffold(
    //           appBar: AppBar(
    //             backgroundColor: Color.fromRGBO(7, 95, 86, 1),
    //           ),
    //           body: Column(children: [
    //             CircleAvatar(
    //               child: Text("abc"),
    //             ),
    //             ElevatedButton(onPressed: getData, child: Text("abc btn")),
    //           ])));
    // }

    // getData() async* {
    //   User user = await FirebaseAuth.instance.currentUser!;
    //   FirebaseFirestore.instance
    //       .collection('usersInfo')
    //       .doc(user.uid)
    //       .get()
    //       .whenComplete((value) {
    //     setState(() {
    //       data = value as List;
    //     });
    // });
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersInfo');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // return Text("Full Name: ${data['name']} ${data['phoneNum']}");
          return MaterialApp(
              home: Column(
            children: [
              Container(
                height: height,
                width: width,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(7, 95, 86, 1),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      },
                    ),
                    title: Text("Settings"),
                  ),
                  body: Row(
                    children: [
                      ClipOval(
                          child: Image.network(
                        data['user-img'],
                        fit: BoxFit.cover,
                        width: 90.0,
                        height: 90.0,
                      )),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "${data['name']}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
        }

        return Text("loading");
      },
    );
  }
}
