import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsap_ui/home.dart';
import 'package:whatsap_ui/login.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({Key? key}) : super(key: key);

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    var ch = FirebaseAuth.instance.currentUser;
    // ignore: unnecessary_null_comparison
    if (ch?.uid != null) {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => LoginScreen()));
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home()));
      });
    } else {
      
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
    return Container();
  }
}
