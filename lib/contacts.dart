// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, await_only_futures, unused_import

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:permission_handler/permission_handler.dart';

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
    //   return MaterialApp(
    //       home: Scaffold(
    //           //         body: ListView.builder(
    //           //   itemCount: Allcontacts.length,
    //           //   itemBuilder: (context, index) {
    //           //     Contact contact = Allcontacts[index];
    //           //     return ListTile(
    //           //       title: Text(contact.displayNam),
    //           //     );
    //           //   },
    //           // )
    //           // body: ElevatedButton(
    //           //   child: Text("press"),
    //           //   onPressed: abc,
    //           // ),
    //           body:

    //       (Allcontacts == null)
    //           ? Center(
    //               child: CircularProgressIndicator(),
    //             )
    //           : ListView.builder(
    //               itemCount: firephonenum.toString().length,
    //               itemBuilder: (context, index) {
    //                 return ListTile(
    //                   title: Text(firephonenum.toString()),
    //                   //  leading: CircleAvatar(backgroundImage: MemoryImage(Allcontacts![index].avatar!),),
    //                   //  leading:  Allcontacts![index].avatar != null
    //                   //                   ? ClipOval(
    //                   //                       child: CircleAvatar(
    //                   //                         backgroundImage: MemoryImage(Allcontacts![index].avatar!),                                )
    //                   //                     )
    //                   //                   : CircleAvatar(
    //                   //                       maxRadius: 60,
    //                   //                       child: Icon(
    //                   //                         Icons.account_circle_rounded,
    //                   //                         size: 128,
    //                   //                       ),
    //                   //                       backgroundColor: Colors.transparent,
    //                   //                     ),
    //                 );
    //               },
    //             ),

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
            return ListTile(
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
                        backgroundColor: Colors.transparent,
                      ),
                title: Text(data['num']));
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
        setState(() {
          firephonenum = doc.get('num');
          fireUserUID = doc.id;
        });
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
    // print(contacts.map((e) => print(e.phones!.map((e) => print(e.value)))));
    var a = contacts.map((e) => e.displayName);
    var b = contacts;
    if (a != null) {
      print(a);
    } else {
      print(b);
    }
    // Get all contacts without thumbnail (faster)
    print(johns.map((e) => e.phones!.first.value));
    // print("firephonenum" + fireUserData);
    // ignore: unused_local_variable
//         var projectId = "com.example.whatsap_ui";
// await FirebaseAdmin.instance.initializeApp(
//   AppOptions(
//     credential: await Credentials.firebaseAdminCredentialPath.
//     )
// ).auth().getUserByPhoneNumber(chPhones?[chPhones!.length].phones?.first.value.toString() ?? "")
//      .then((userRecord) => print("userUID=" + userRecord.uid))
//      .catchError((error) => print(error));
    var ag = await firephonenum;
    print("the data : " + await ag.toString().characters.toString());
  }

  
}
