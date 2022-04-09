import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    "Ali",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    "Asad",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    "Qasim",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    "asim",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    "doctor",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    "police",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
