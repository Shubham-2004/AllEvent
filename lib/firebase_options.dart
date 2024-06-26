// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyA-16Gvk_lFKSpilGvUkqteb4frj1glRCo',
    appId: '1:438561053629:web:84aef008bd1c83779a10d4',
    messagingSenderId: '438561053629',
    projectId: 'chatapp-8567f',
    authDomain: 'chatapp-8567f.firebaseapp.com',
    storageBucket: 'chatapp-8567f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1c6xu1fgfsz7BMtV4uJKAX2QXahUcaAc',
    appId: '1:438561053629:android:9d4b3ef97c12d99e9a10d4',
    messagingSenderId: '438561053629',
    projectId: 'chatapp-8567f',
    storageBucket: 'chatapp-8567f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDT-1DTomAY-8WqaXdUhc7x292fQAJltwc',
    appId: '1:438561053629:ios:5ef1928536ec39aa9a10d4',
    messagingSenderId: '438561053629',
    projectId: 'chatapp-8567f',
    storageBucket: 'chatapp-8567f.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDT-1DTomAY-8WqaXdUhc7x292fQAJltwc',
    appId: '1:438561053629:ios:5ef1928536ec39aa9a10d4',
    messagingSenderId: '438561053629',
    projectId: 'chatapp-8567f',
    storageBucket: 'chatapp-8567f.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-16Gvk_lFKSpilGvUkqteb4frj1glRCo',
    appId: '1:438561053629:web:329c256e313667059a10d4',
    messagingSenderId: '438561053629',
    projectId: 'chatapp-8567f',
    authDomain: 'chatapp-8567f.firebaseapp.com',
    storageBucket: 'chatapp-8567f.appspot.com',
  );
}
