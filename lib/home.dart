import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsap_ui/chats.dart';
import 'package:whatsap_ui/contacts.dart';
import 'package:whatsap_ui/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

var searchbox = {
  TextField(
    decoration: InputDecoration(
      hintText: "Enter a message",
    ),
  )
};

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(7, 95, 86, 1),
          title: Text("whatsApp"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                if (searchbox == searchbox) {}
              },
            ),
            PopupMenuButton(
                onSelected: (result) {
                  if (result == 5) {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SettingsPage()));
                  } else if (result == 1) {
                    Fluttertoast.showToast(msg: 'group');
                  }
                },
                color: Colors.white,
                itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text("New group"),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Text("New broadcast"),
                      ),
                      PopupMenuItem<int>(
                        value: 3,
                        child: Text("Linked Devices"),
                      ),
                      PopupMenuItem<int>(
                        value: 4,
                        child: Text("Starred messages"),
                      ),
                      PopupMenuItem<int>(
                        value: 5,
                        child: Text("Settings"),
                      )
                    ]),
          ]

          //         <Widget>[

          //          IconButton(
          //     icon: Icon(
          //       Icons.search,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       // do something
          //     },
          //   ),
          //   IconButton(
          //     icon: Icon(
          //       Icons.chat,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       // do something
          //     },
          //   ),
          //   IconButton(
          //     icon: Icon(
          //       Icons.more_vert,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       // do something
          //     },
          //   )
          // ],
          ,
          bottom: TabBar(tabs: [
            Tab(
              child: Text("CHATS"),
            ),
            Tab(
              child: Text("CALLS"),
            ),
            Tab(
              child: Text("CONTACTS"),
            ),
          ]),
        ),
        body: TabBarView(
          children: [Chats(), Chats(), Contacts()],
        ),
      ),
    );
  }
}
