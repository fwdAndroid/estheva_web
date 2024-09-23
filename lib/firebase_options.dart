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
    apiKey: 'AIzaSyBH-Afd_JNXfgnT2CZ1d_K9QR1ICV3RNr4',
    appId: '1:934119296637:web:8f6d1fdc1818e2c42e2b14',
    messagingSenderId: '934119296637',
    projectId: 'estheva-5127e',
    authDomain: 'estheva-5127e.firebaseapp.com',
    storageBucket: 'estheva-5127e.appspot.com',
    measurementId: 'G-K3LRCMTT1N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9a3NQZYQWUp3-NkbEzOjvS6b-3OtgrFo',
    appId: '1:934119296637:android:bfb3ac6c4a4b34eb2e2b14',
    messagingSenderId: '934119296637',
    projectId: 'estheva-5127e',
    storageBucket: 'estheva-5127e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABeheU-ha2Rp_ZIkUmIscFaS8--McU1Uo',
    appId: '1:934119296637:ios:1f61a7d49ddfd65b2e2b14',
    messagingSenderId: '934119296637',
    projectId: 'estheva-5127e',
    storageBucket: 'estheva-5127e.appspot.com',
    iosBundleId: 'com.example.esthevaWeb',
  );

}