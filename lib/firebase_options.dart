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
    apiKey: 'AIzaSyC1AZpuDIdfpenLZ44ErFjVZ8a4PwX7h4w',
    appId: '1:795750798501:web:00d9d047056b22e9e1a94c',
    messagingSenderId: '795750798501',
    projectId: 'haupass-6aa5a',
    authDomain: 'haupass-6aa5a.firebaseapp.com',
    storageBucket: 'haupass-6aa5a.appspot.com',
    measurementId: 'G-9KPMP2GK2C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkdIMRSiJhMR0A-AoR6zN5EasLub-2Gp0',
    appId: '1:795750798501:android:53b778c18f0671a0e1a94c',
    messagingSenderId: '795750798501',
    projectId: 'haupass-6aa5a',
    storageBucket: 'haupass-6aa5a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLZQdicj1X-Ax35AXNQD2G82i1_mUoOKA',
    appId: '1:795750798501:ios:44b479e1d1a2849ae1a94c',
    messagingSenderId: '795750798501',
    projectId: 'haupass-6aa5a',
    storageBucket: 'haupass-6aa5a.appspot.com',
    iosBundleId: 'com.example.finalAdet',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLZQdicj1X-Ax35AXNQD2G82i1_mUoOKA',
    appId: '1:795750798501:ios:44b479e1d1a2849ae1a94c',
    messagingSenderId: '795750798501',
    projectId: 'haupass-6aa5a',
    storageBucket: 'haupass-6aa5a.appspot.com',
    iosBundleId: 'com.example.finalAdet',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC1AZpuDIdfpenLZ44ErFjVZ8a4PwX7h4w',
    appId: '1:795750798501:web:4ee7b553a05aa168e1a94c',
    messagingSenderId: '795750798501',
    projectId: 'haupass-6aa5a',
    authDomain: 'haupass-6aa5a.firebaseapp.com',
    storageBucket: 'haupass-6aa5a.appspot.com',
    measurementId: 'G-6H1G0WS4MN',
  );
}