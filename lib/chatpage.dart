import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChattingPage extends StatelessWidget {
  ChattingPage({Key? key, this.avatar, this.name, this.uid, this.num})
      : super(key: key);
  var b;
  var num;
  TextEditingController chatController = TextEditingController();
  var uid;
  final avatar;
  final name;
  var firePhoneNum;
  var docname;

  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      print("no uid found");
    } else {
      print("uid" + uid);
    }
    // ignore: unused_local_variable
    var docId =
        uid.toString().compareTo(FirebaseAuth.instance.currentUser!.uid) > 0
            ? uid! + FirebaseAuth.instance.currentUser!.uid
            : FirebaseAuth.instance.currentUser!.uid + uid!;
    if (uid!.toString().length >
        FirebaseAuth.instance.currentUser!.uid.length) {
      docname = uid! + FirebaseAuth.instance.currentUser!.uid;
    } else {
      docname = FirebaseAuth.instance.currentUser!.uid + uid!;
    }
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        // title: name,
        backgroundColor: Color.fromRGBO(7, 95, 86, 1),
        leading: Row(
          children: [
            // SizedBox(width: 100,),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // SizedBox(width: 100,),
          ],
        ),

        // title: name,
        // CircleAvatar(backgroundImage: NetworkImage(avatar),),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 160),
            child: Stack(
              children: [
                // CircleAvatar(
                //   backgroundImage: NetworkImage(avatar,),radius: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 87),
                  child: ClipOval(
                    child: Image.network(
                      avatar,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 20),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // appBar: ,
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Chats")
                .doc(docId)
                .collection("messages")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                        var nu = data[FirebaseAuth.instance.currentUser!.uid];
                    return Row(
                      children: [
                        Text("d=""$nu",style: TextStyle(backgroundColor: Colors.green),),
                      (data[uid!]!=null) ? Text(data[uid!]):Text("")
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance
          //       .collection("Chats")
          //       .doc(docId)
          //       .collection("messages")
          //       .snapshots(),
          //   builder:
          //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.hasError) {
          //       return Text('Something went wrong');
          //     }

          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Text("Loading");
          //     }

          //     return Expanded(
          //       child: ListView(
          //         children:
          //             snapshot.data!.docs.map((DocumentSnapshot document) {
          //           Map<String, dynamic> data =
          //               document.data()! as Map<String, dynamic>;
          //           return ListTile(
          //             title:
          //                data!=null? Text(data[FirebaseAuth.instance.currentUser!.uid]):null,
          //             // subtitle: Text(data['company']),

          //             subtitle:data!=null ?Text(data[uid!]):null,

          //           );
          //         }).toList(),
          //       ),
          //     );
          //   },
          // ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                // First child is enter comment text input
                Expanded(
                  child: TextFormField(
                    controller: chatController,
                    autocorrect: false,
                    decoration: new InputDecoration(
                      labelText: "Some Text",
                      labelStyle:
                          TextStyle(fontSize: 20.0, color: Colors.white),
                      fillColor: Colors.blue,
                      border: OutlineInputBorder(
                          // borderRadius:
                          //     BorderRadius.all(Radius.zero(5.0)),
                          borderSide: BorderSide(color: Colors.purpleAccent)),
                    ),
                  ),
                ),
                // Second child is button
                IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 20.0,
                  onPressed: () async {
                    print(chatController.text);
                    // await FirebaseFirestore.instance
                    //     .collection("Chats")
                    //     .doc(docId)
                    //     .collection("messages")
                    //     .add({
                    //   FirebaseAuth.instance.currentUser!.uid:
                    //       chatController.text,
                    // }).then((value) => () {
                    //           b = uid;
                    //         });
                    var ref = FirebaseAuth.instance.currentUser!.uid;
                    FirebaseFirestore.instance
                        .collection("Chats")
                        .doc(docId)
                        .collection("messages")
                        .add({
                      "$ref": chatController.text,
                    });
                    chatController.clear();
                    print(docId);
                    // await FirebaseFirestore.instance
                    //     .collection('Chats')
                    //     .doc(uid! + FirebaseAuth.instance.currentUser!.uid)
                    //     .collection("messages")
                    //     .get()
                    //     .then((QuerySnapshot querySnapshot) {
                    //   querySnapshot.docs.forEach((doc) {
                    //     print(doc['PhoneNum']);
                    //   });
                    // });
                    await FirebaseFirestore.instance
                        .collection("Chats")
                        .doc(docId)
                        .collection("messages")
                        .get()
                        .then((value) => print(
                            value.docs.map((e) => print(e.data().toString()))));
                    FirebaseFirestore.instance
                        .collection("chatting users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        print('doc exists');
                      } else {
                        FirebaseFirestore.instance
                            .collection("chatting users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("profiledata")
                            .add({
                          "PhoneNum": num,
                          "avatar": avatar,
                          "uid": FirebaseAuth.instance.currentUser!.uid,
                          "name": name,
                        });
                      }
                    });
                  },
                )
              ])),
        ],
      ),
    ));
  }
}
