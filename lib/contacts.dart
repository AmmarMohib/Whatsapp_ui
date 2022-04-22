// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, await_only_futures
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact>? Allcontacts;
   List<Contact>? chPhones;
  List<Item> phones = [];
  var firephonenum;
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
            body: (Allcontacts == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: chPhones!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(Allcontacts![index].displayName.toString()),
                        //  leading: CircleAvatar(backgroundImage: MemoryImage(Allcontacts![index].avatar!),),
                        //  leading:  Allcontacts![index].avatar != null
                        //                   ? ClipOval(
                        //                       child: CircleAvatar(
                        //                         backgroundImage: MemoryImage(Allcontacts![index].avatar!),                                )
                        //                     )
                        //                   : CircleAvatar(
                        //                       maxRadius: 60,
                        //                       child: Icon(
                        //                         Icons.account_circle_rounded,
                        //                         size: 128,
                        //                       ),
                        //                       backgroundColor: Colors.transparent,
                        //                     ),
                      );
                    },
                  )));
  }

  abc() async {
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    await FirebaseFirestore.instance
        .collection("numbers&avatars")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['num']);
        setState(() {
          firephonenum = doc['num'];
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
    print(johns.map((e) => e.phones!.first.value
    
    ));
  }
}
