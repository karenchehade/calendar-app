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
        return macos;
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
    apiKey: 'AIzaSyCdG8kBwLNmHtV7WE1q8mL03CZiMAE4iGI',
    appId: '1:309671283374:web:5ae8eac09b7482d3c03b3f',
    messagingSenderId: '309671283374',
    projectId: 'calendar-88a4c',
    authDomain: 'calendar-88a4c.firebaseapp.com',
    storageBucket: 'calendar-88a4c.appspot.com',
    measurementId: 'G-FQL56X25NG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZw8rlDE4q73mNLGo2xpO67Q4CrCtsjsY',
    appId: '1:309671283374:android:da4d042e4bc5df1fc03b3f',
    messagingSenderId: '309671283374',
    projectId: 'calendar-88a4c',
    storageBucket: 'calendar-88a4c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1T7fi9QyYJhp3KKrtcrXpiLEzjs6DZZM',
    appId: '1:309671283374:ios:4b7df09c2f094c33c03b3f',
    messagingSenderId: '309671283374',
    projectId: 'calendar-88a4c',
    storageBucket: 'calendar-88a4c.appspot.com',
    iosClientId: '309671283374-u8p5fcqsd1fus5b32uib6eqtsljp2pfv.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseSetup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1T7fi9QyYJhp3KKrtcrXpiLEzjs6DZZM',
    appId: '1:309671283374:ios:4b7df09c2f094c33c03b3f',
    messagingSenderId: '309671283374',
    projectId: 'calendar-88a4c',
    storageBucket: 'calendar-88a4c.appspot.com',
    iosClientId: '309671283374-u8p5fcqsd1fus5b32uib6eqtsljp2pfv.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseSetup',
  );
}
