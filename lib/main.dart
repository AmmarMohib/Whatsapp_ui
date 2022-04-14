// ignore_for_file: unnecessary_null_comparison, await_only_futures, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsap_ui/checkuser.dart';
import 'package:whatsap_ui/firebase_options.dart';
// import 'package:whatsap_ui/home.dart';
import 'package:whatsap_ui/login.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform
 );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckUser(),
    );
  }
}