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
                            .collection("chatting users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("profiledata")
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
                  //       CircleAvatar(
                  //         radius: 30.0,
                  //         backgroundImage: NetworkImage(
                  //             'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                  //         backgroundColor: Colors.transparent,
                  //       ),
                  //       Text(
                  //         "Ali",
                  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  //       )
                  //     ],
                  //   ),
                  //   Row(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 30.0,
                  //         backgroundImage: NetworkImage(
                  //             'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                  //         backgroundColor: Colors.transparent,
                  //       ),
                  //       Text(
                  //         "Asad",
                  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  //       )
                  //     ],
                  //   ),
                  //   Row(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 30.0,
                  //         backgroundImage: NetworkImage(
                  //             'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                  //         backgroundColor: Colors.transparent,
                  //       ),
                  //       Text(
                  //         "Qasim",
                  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  //       )
                  //     ],
                  //   ),
                  //   Row(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 30.0,
                  //         backgroundImage: NetworkImage(
                  //             'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                  //         backgroundColor: Colors.transparent,
                  //       ),
                  //       Text(
                  //         "asim",
                  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  //       )
                  //     ],
                  //   ),
                  //   Row(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 30.0,
                  //         backgroundImage: NetworkImage(
                  //             'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                  //         backgroundColor: Colors.transparent,
                  //       ),
                  //       Text(
                  //         "doctor",
                  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  //       )
                  //     ],
                  //   ),
                  //   Row(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 30.0,
                  //         backgroundImage: NetworkImage(
                  //             'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                  //         backgroundColor: Colors.transparent,
                  //       ),
                  //       Text(
                  //         "police",
                  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  //       )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  goChats(uid, name, avatar) async {
    // List<Contact> johns =
    // await ContactsService.getContactsForPhone(firephonenum.toString());
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
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => ChattingPage(
    //               name: name,
    //               avatar: avatar,
    //               uid: uid,
    //             )));
  }
}
