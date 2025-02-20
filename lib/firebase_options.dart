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
    apiKey: 'AIzaSyDl-CIVVZKrKSNvoduPhqel0QQJiHLdVx8',
    appId: '1:883458926805:web:9b4c33fc047c05da785a5c',
    messagingSenderId: '883458926805',
    projectId: 'timbox-17743',
    authDomain: 'timbox-17743.firebaseapp.com',
    storageBucket: 'timbox-17743.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHm6-5aueTBn36dDY8cUzzUrtr74eQVdE',
    appId: '1:883458926805:android:7628ae8c91059600785a5c',
    messagingSenderId: '883458926805',
    projectId: 'timbox-17743',
    storageBucket: 'timbox-17743.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDy2tK7Zk2rYhcT3ZnpvaFuseASKjyFR9U',
    appId: '1:883458926805:ios:0b542b1a4b1d797c785a5c',
    messagingSenderId: '883458926805',
    projectId: 'timbox-17743',
    storageBucket: 'timbox-17743.firebasestorage.app',
    iosBundleId: 'com.example.timbox',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDl-CIVVZKrKSNvoduPhqel0QQJiHLdVx8',
    appId: '1:883458926805:web:0f12ad26a2e339c7785a5c',
    messagingSenderId: '883458926805',
    projectId: 'timbox-17743',
    authDomain: 'timbox-17743.firebaseapp.com',
    storageBucket: 'timbox-17743.firebasestorage.app',
  );
}
