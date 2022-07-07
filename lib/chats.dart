import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsap_ui/chatpage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  // Chatss({String? data, b, data2});
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var uid;
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                    .collection("Chats")
                        .doc("users")
                        .collection(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      return Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return ListTile(
                              
                              onTap: () => goChats(
                                  // ignore: unnecessary_null_comparison
                                   data['uid'], data['name'], data['avatar']),
                              // ignore: unnecessary_null_comparison
                              leading: data != null
                                  ? ClipOval(
                                      child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(data['avatar']),
                                    ))
                                  : CircleAvatar(
                                      maxRadius: 60,
                                      child: Icon(
                                        Icons.account_circle_rounded,
                                        size: 128,
                                      ),
                                      // backgroundColor: Colors.transparent,
                                    ),
                              title: Text(data['name']),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  goChats(uid, name, avatar) async {
    print(uid);
    print(name);
    print(avatar);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChattingPage(
                name: name,
                avatar: avatar,
                uid: uid,
              )),
    );
  }
}