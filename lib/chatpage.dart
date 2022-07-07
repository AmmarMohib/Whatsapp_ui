// ignore_for_file: non_constant_identifier_names


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ChattingPage extends StatefulWidget {
  ChattingPage({Key? key, this.avatar, this.name, this.uid, this.num})
      : super(key: key);
  var num;
  var uid;
  final avatar;
  final name;

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  var CAB;
  bool _messageSelected = true;
  void appBarChange() {
    setState(() {
      _messageSelected = !_messageSelected;
    });
  }

  var b;

  TextEditingController chatController = TextEditingController();

  var firePhoneNum;
  var docname;

  var e;
  Widget _defaultBar(BuildContext context, Function changeAppBar) {
    CAB = appBarChange;
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromRGBO(7, 95, 86, 1),
      leading: Padding(
        padding: EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(widget.avatar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.videocam, size: 20),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.call, size: 20),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert, size: 20),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _editingBar(BuildContext context, Function changeAppBar) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromRGBO(7, 95, 86, 1),
      leading: IconButton(
        icon: Icon(Icons.delete),
        color: Theme.of(context).iconTheme.color,
        onPressed: () {
//          ;
//       var docRef =  FirebaseFirestore.instance
//                           .collection("Chats")
//                           .doc(widget.uid
//                 .toString()
//                 .compareTo(FirebaseAuth.instance.currentUser!.uid) >
//             0
//         ? widget.uid! + FirebaseAuth.instance.currentUser!.uid
//         : FirebaseAuth.instance.currentUser!.uid + widget.uid!).collection("messages").doc();

//                           final updates = <String, dynamic>{
//   "messages": FieldValue.delete(),
// };

// docRef.update(updates);

//           CAB();
//           // CAB = changeAppBar();
FirebaseFirestore.instance.collection("Chats").doc(widget.uid
                .toString()
                .compareTo(FirebaseAuth.instance.currentUser!.uid) >
            0
        ? widget.uid! + FirebaseAuth.instance.currentUser!.uid
        : FirebaseAuth.instance.currentUser!.uid + widget.uid!).collection("messages").get().then((value) => print(value.docs.map((e) => print(e.get(FirebaseAuth.instance.currentUser!.uid)))));
        FirebaseFirestore.instance.collection("Chats").doc(widget.uid
                .toString()
                .compareTo(FirebaseAuth.instance.currentUser!.uid) >
            0
        ? widget.uid! + FirebaseAuth.instance.currentUser!.uid
        : FirebaseAuth.instance.currentUser!.uid + widget.uid!).collection('messages').get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
               doc.reference.update({widget.uid: FieldValue.delete()}).whenComplete((){
  print('Field Deleted');
});
        });
});
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.check),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.event),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.uid == null) {
      print("no uid found");
    } else {
      print("uid" + widget.uid);
    }
    // ignore: unused_local_variable
    var docId = widget.uid
                .toString()
                .compareTo(FirebaseAuth.instance.currentUser!.uid) >
            0
        ? widget.uid! + FirebaseAuth.instance.currentUser!.uid
        : FirebaseAuth.instance.currentUser!.uid + widget.uid!;
    if (widget.uid!.toString().length >
        FirebaseAuth.instance.currentUser!.uid.length) {
      docname = widget.uid! + FirebaseAuth.instance.currentUser!.uid;
    } else {
      docname = FirebaseAuth.instance.currentUser!.uid + widget.uid!;
    }
    return MaterialApp(
        home: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: _messageSelected
            ? _defaultBar(context, appBarChange)
            : _editingBar(context, appBarChange),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Chats")
                  .doc(docId)
                  .collection("messages")
                  .orderBy('sentdate')
                  .orderBy('sentOn')
                  .snapshots(includeMetadataChanges: true),
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
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                (data[FirebaseAuth.instance.currentUser!.uid] !=
                                        null)
                                    ? InkWell(
                                        onLongPress: () {
                                          this.activate();
                                          print("long pressed");
                                          CAB();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade200,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(13.0),
                                            child: Row(
                                              children: [
                                                (data[FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid] !=
                                                        null)
                                                    ? Text(
                                                        "${data[FirebaseAuth.instance.currentUser!.uid]} ",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    : Text(
                                                        "",
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                (data[FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid] !=
                                                        null)
                                                    ? Text(
                                                        data['sentOn'],
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      )
                                                    : Text("")
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                (data[widget.uid] != null)
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: Column(
                                            children: [
                                              Text(widget.name),
                                              Row(
                                                children: [
                                                  (data[widget.uid] != null)
                                                      ? Text(
                                                          "${data[widget.uid]} ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      : Container(),
                                                  (data[widget.uid!] != null)
                                                      ? Text(
                                                          data['sentOn'],
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
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
                      // DateTime now = DateTime.now();
// print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());
                      FirebaseFirestore.instance.settings = const Settings(
                        persistenceEnabled: true,
                        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
                      );

                      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                      final now = new DateTime.now();
                      String formatter =
                          DateFormat('yMd').format(now); // 28/03/2020
                      print(formatter);
                      print(dateFormat);
                      dynamic currentTime =
                          DateFormat.jm().format(DateTime.now());
                      e = currentTime;
                      var ref = FirebaseAuth.instance.currentUser!.uid;
                      FirebaseFirestore.instance
                          .collection("Chats")
                          .doc(docId)
                          .collection("messages")
                          .add({
                        "$ref": chatController.text,
                        "sentOn": currentTime,
                        "sentdate": formatter
                      });
                      await FirebaseFirestore.instance
                          .collection("Chats")
                          .doc("users")
                          .collection(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((snapshot) {
                        var data = snapshot.docs.map((e) => e.get('uid'));
                        // print(snapshot.docs.length == 0);
                        print(data);
                        // ignore: unrelated_type_equality_checks
                        if (data.length == 0) {
                          print("No collection");
                          FirebaseFirestore.instance
                              .collection("Chats")
                              .doc("users")
                              .collection(
                                  FirebaseAuth.instance.currentUser!.uid)
                              .add({
                            "uid": widget.uid,
                            "name": widget.name,
                            "avatar": widget.avatar
                          });
                        }
                      });
                      await FirebaseFirestore.instance
                          .collection("Chats")
                          .doc("users")
                          .collection(widget.uid)
                          .get()
                          .then((snapshot) {
                        // print(snapshot.docs.length == 0);
                        var data = snapshot.docs.map((e) => e.get('uid'));
                        // ignore: unrelated_type_equality_checks
                        if (data.length == 0) {
                          FirebaseFirestore.instance
                              .collection("usersInfo")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get()
                              .then((snapshot) {
                            print("No collection");
                            var name = snapshot.get('name');
                            var userimg = snapshot.get('user-img');
                            FirebaseFirestore.instance
                                .collection("Chats")
                                .doc("users")
                                .collection(widget.uid)
                                .add({
                              "uid": FirebaseAuth.instance.currentUser!.uid,
                              "name": name,
                              "avatar": userimg
                            });
                          });
                        }
                      });

                      chatController.clear();
                      print(docId);
                    },
                  )
                ])),
          ],
        ),
      ),
    ));
  }
}
