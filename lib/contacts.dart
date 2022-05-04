// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, await_only_futures, unused_import

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsap_ui/chatpage.dart';
import 'package:whatsap_ui/chats.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact>? Allcontacts;
  List<Contact>? chPhones;
  var fireUserUID;
  var fireUserData;
  List<Item> phones = [];
  var firephonenum;
  @override
  void initState() {
    super.initState();
    abc();
  }

  Widget build(BuildContext context) {
    // ));
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('numbers&avatars').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return  ListTile(
                onTap: () =>
                    contactpopup(data['Uid'], data['avatar'], data['name'],data['num']),
                leading: data != null
                    ? ClipOval(
                        child: CircleAvatar(
                        backgroundImage: NetworkImage(data['avatar']),
                      ))
                    : CircleAvatar(
                        maxRadius: 60,
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 128,
                        ),
                        // backgroundColor: Colors.transparent,
                      ),
                title: Text(data['name']));
          }).toList(),
        );
      },
    );
  }

  abc() async {
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    await FirebaseFirestore.instance
        .collection("numbers&avatars")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.get('num').toString().length);
        // print("id" + doc.id);
      });
    });

    List<Contact> johns =
        await ContactsService.getContactsForPhone(firephonenum.toString());

    //     if(contacts != null){
    //   var fcontact = int.parse(contacts.toString());
    //   setState(() {
    //     Allcontacts = fcontact.toString() as List<Contact>;
    //   });
    // }
    setState(() {
      Allcontacts = contacts;
      chPhones = johns;
    });
    var a = contacts.map((e) => e.displayName);
    var b = contacts;
    if (a != null) {
      print(a);
    } else {
      print(b);
    }
    // Get all contacts without thumbnail (faster)
    print(johns.map((e) => e.phones!.first.value));
    var ag = await firephonenum;
    print("the data : " + await ag.toString().characters.toString());
  }

  Future contactpopup(String string, data, name,num) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Stack(
            clipBehavior: Clip.antiAlias,
            children: <Widget>[
              TextButton(
                  onPressed: () => firepush(string, data, name,num),
                  child: Text(
                    "chat with contact",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ));
        });
  }

  firepush(string, data, name,num) {
    print(string);
    print(FirebaseAuth.instance.currentUser!.phoneNumber);
    print(string);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ChattingPage(
                  uid: string.toString(),
                  avatar: data,
                  name: name,
                  num: num,  
                )));
  }
}
