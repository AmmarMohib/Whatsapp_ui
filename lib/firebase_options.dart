// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCdh38RV7X_MD84Iu9q_D6-Le5LCVOLx0A',
    appId: '1:1019305910639:web:72261b5f99dc9c827d889a',
    messagingSenderId: '1019305910639',
    projectId: 'whatsapp-5f070',
    authDomain: 'whatsapp-5f070.firebaseapp.com',
    databaseURL: 'https://whatsapp-5f070-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'whatsapp-5f070.appspot.com',
    measurementId: 'G-Z82LYKYSCE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2OsXaHCO8pxMneLhosWXx3YNtBGVthBg',
    appId: '1:1019305910639:android:89022f1bd127835a7d889a',
    messagingSenderId: '1019305910639',
    projectId: 'whatsapp-5f070',
    databaseURL: 'https://whatsapp-5f070-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'whatsapp-5f070.appspot.com',
  );
}