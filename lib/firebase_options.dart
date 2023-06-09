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
    apiKey: 'AIzaSyAqRRMFaZoUTnmOc0hep1GroJK_TSlKQtU',
    appId: '1:751560248045:web:5f8f5ccdb2b205bab0dae4',
    messagingSenderId: '751560248045',
    projectId: 'chat-app-f2957',
    authDomain: 'chat-app-f2957.firebaseapp.com',
    storageBucket: 'chat-app-f2957.appspot.com',
    measurementId: 'G-YPEGNXMDX7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyM5l1Q-NoFOf3pgQyfSzY-kIBBwStfvA',
    appId: '1:751560248045:android:d2492c63170a2b0ab0dae4',
    messagingSenderId: '751560248045',
    projectId: 'chat-app-f2957',
    storageBucket: 'chat-app-f2957.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCiM8wbDVQ7WO2k8pJyqjWjsl-ucipfYp8',
    appId: '1:751560248045:ios:2a94e157624c13e4b0dae4',
    messagingSenderId: '751560248045',
    projectId: 'chat-app-f2957',
    storageBucket: 'chat-app-f2957.appspot.com',
    iosClientId: '751560248045-1qtd08pdf0qqa2hhfd6peh7it0ldv38e.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCiM8wbDVQ7WO2k8pJyqjWjsl-ucipfYp8',
    appId: '1:751560248045:ios:2a94e157624c13e4b0dae4',
    messagingSenderId: '751560248045',
    projectId: 'chat-app-f2957',
    storageBucket: 'chat-app-f2957.appspot.com',
    iosClientId: '751560248045-1qtd08pdf0qqa2hhfd6peh7it0ldv38e.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterChat',
  );
}
