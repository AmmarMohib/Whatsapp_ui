import 'package:flutter/material.dart';
// import 'package:whatsap_ui/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsap_ui/firebase_options.dart';
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
      home: LoginScreen(),
    );
  }
}