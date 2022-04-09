import 'package:flutter/material.dart';
import 'package:whatsap_ui/chats.dart';

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
                color: Colors.white,
                itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("New group"),
                      ),
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("New broadcast"),
                      ),
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("Linked Devices"),
                      ),
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("Starred messages"),
                      ),
                      PopupMenuItem<int>(
                        value: 0,
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
          children: [Chats(), Chats(), Text("data")],
        ),
      ),
    );
  }
}
