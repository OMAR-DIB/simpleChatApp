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
    apiKey: 'AIzaSyAqD4VkMqmJ1yDc03m4IYncJeRfP5QRs8U',
    appId: '1:257112730513:web:ec1b6935bdb5b2d877c830',
    messagingSenderId: '257112730513',
    projectId: 'chatnew-e3743',
    authDomain: 'chatnew-e3743.firebaseapp.com',
    storageBucket: 'chatnew-e3743.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1KS8M34Mw0uPjb5PxK8e9h5f6Wj5wRJk',
    appId: '1:257112730513:android:e2a893529398f34f77c830',
    messagingSenderId: '257112730513',
    projectId: 'chatnew-e3743',
    storageBucket: 'chatnew-e3743.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_GW1JpMb916pUKcOjudPY_vIkBU9O1zU',
    appId: '1:257112730513:ios:631a9c0fd03d738977c830',
    messagingSenderId: '257112730513',
    projectId: 'chatnew-e3743',
    storageBucket: 'chatnew-e3743.appspot.com',
    iosBundleId: 'com.example.chatNew',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_GW1JpMb916pUKcOjudPY_vIkBU9O1zU',
    appId: '1:257112730513:ios:631a9c0fd03d738977c830',
    messagingSenderId: '257112730513',
    projectId: 'chatnew-e3743',
    storageBucket: 'chatnew-e3743.appspot.com',
    iosBundleId: 'com.example.chatNew',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAqD4VkMqmJ1yDc03m4IYncJeRfP5QRs8U',
    appId: '1:257112730513:web:7c4468e314f4f60277c830',
    messagingSenderId: '257112730513',
    projectId: 'chatnew-e3743',
    authDomain: 'chatnew-e3743.firebaseapp.com',
    storageBucket: 'chatnew-e3743.appspot.com',
  );
}
