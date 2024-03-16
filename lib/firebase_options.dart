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
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB1Xah0-72Z4YIaiEDgmnnmSXv2B6eWke8',
    appId: '1:225853059005:web:0afd9f7932130f5144acd4',
    messagingSenderId: '225853059005',
    projectId: 'trysayari',
    authDomain: 'trysayari.firebaseapp.com',
    databaseURL: 'https://trysayari-default-rtdb.firebaseio.com',
    storageBucket: 'trysayari.appspot.com',
    measurementId: 'G-SYMJ5W710W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYsdacVwE_Bj-lIhyQ3yARME5ShLiJ2yc',
    appId: '1:225853059005:android:dc8786152cb796b144acd4',
    messagingSenderId: '225853059005',
    projectId: 'trysayari',
    databaseURL: 'https://trysayari-default-rtdb.firebaseio.com',
    storageBucket: 'trysayari.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYMd9AnA92NSTw9PRYtGz9MY3HuXuDoTs',
    appId: '1:225853059005:ios:221d6fd4df25702044acd4',
    messagingSenderId: '225853059005',
    projectId: 'trysayari',
    databaseURL: 'https://trysayari-default-rtdb.firebaseio.com',
    storageBucket: 'trysayari.appspot.com',
    iosBundleId: 'com.sessions.app',
  );
}