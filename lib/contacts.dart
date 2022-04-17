// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact>? Allcontacts;
  List<Item> phones = [];
  @override
  void initState() {
    super.initState();
    abc();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      //         body: ListView.builder(
      //   itemCount: Allcontacts.length,
      //   itemBuilder: (context, index) {
      //     Contact contact = Allcontacts[index];
      //     return ListTile(
      //       title: Text(contact.displayNam),
      //     );
      //   },
      // )
      // body: ElevatedButton(
      //   child: Text("press"),
      //   onPressed: abc,
      // ),
      body: (Allcontacts == null) ? Center(
        child: CircularProgressIndicator(),
       ):
      ListView.builder(
        itemCount: Allcontacts?.length,
        itemBuilder: (context, index) {
          return ListTile(
           title: Text(Allcontacts![index].displayName.toString()),
          );
        },
      )
    ));
  }

  abc() async {
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
        // List<Contact> johns = await ContactsService.getContacts(query : firebaseaur);

    //     if(contacts != null){
    //   var fcontact = int.parse(contacts.toString());
    //   setState(() {
    //     Allcontacts = fcontact.toString() as List<Contact>;
    //   });
    // }
    setState(() {
      Allcontacts = contacts;
    });
    // print(contacts.map((e) => print(e.phones!.map((e) => print(e.value)))));
    var a = contacts.map((e) => e.displayName);
    var b = contacts;
    if (a != null) {
      print(a);
    } else {
      print(b);
    }
    // Get all contacts without thumbnail (faster)
    print(Allcontacts);
  }
}
