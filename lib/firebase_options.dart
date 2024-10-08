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
    apiKey: 'AIzaSyA5XmIJZhf_VyayarGaJqA3in-X6pwbkuk',
    appId: '1:682694846003:web:1286c61b32c4d39d0c2546',
    messagingSenderId: '682694846003',
    projectId: 'newtok-5e842',
    authDomain: 'newtok-5e842.firebaseapp.com',
    storageBucket: 'newtok-5e842.appspot.com',
    measurementId: 'G-48S7RPTKWP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDF-5ygdIhTi7nsjDLG1t7sQ8Y837-XvAA',
    appId: '1:682694846003:android:1833307b05da84f20c2546',
    messagingSenderId: '682694846003',
    projectId: 'newtok-5e842',
    storageBucket: 'newtok-5e842.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiFXUDU0BiUi-aT1TZ6aYW7sqpKBOsHto',
    appId: '1:682694846003:ios:64ac344df21920530c2546',
    messagingSenderId: '682694846003',
    projectId: 'newtok-5e842',
    storageBucket: 'newtok-5e842.appspot.com',
    iosBundleId: 'com.example.newtok',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBiFXUDU0BiUi-aT1TZ6aYW7sqpKBOsHto',
    appId: '1:682694846003:ios:64ac344df21920530c2546',
    messagingSenderId: '682694846003',
    projectId: 'newtok-5e842',
    storageBucket: 'newtok-5e842.appspot.com',
    iosBundleId: 'com.example.newtok',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA5XmIJZhf_VyayarGaJqA3in-X6pwbkuk',
    appId: '1:682694846003:web:529b8875276ff9590c2546',
    messagingSenderId: '682694846003',
    projectId: 'newtok-5e842',
    authDomain: 'newtok-5e842.firebaseapp.com',
    storageBucket: 'newtok-5e842.appspot.com',
    measurementId: 'G-S4M8HLQJ2X',
  );
}
