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
    apiKey: 'AIzaSyBihoy2pbk2a9Nta1SK3jR-9_TEK8znknY',
    appId: '1:841873054698:web:f551d3f6d6358850e3b093',
    messagingSenderId: '841873054698',
    projectId: 'healthhub-1f4bd',
    authDomain: 'healthhub-1f4bd.firebaseapp.com',
    storageBucket: 'healthhub-1f4bd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWGyN78ozWFNVWozvu16j8BGHfIIpN2ug',
    appId: '1:841873054698:android:8527afc603822c7ee3b093',
    messagingSenderId: '841873054698',
    projectId: 'healthhub-1f4bd',
    storageBucket: 'healthhub-1f4bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDCEPAaP8eW_QLYH1DuIO_ayoUtSRbJCs4',
    appId: '1:841873054698:ios:7ca6c55fe443846ce3b093',
    messagingSenderId: '841873054698',
    projectId: 'healthhub-1f4bd',
    storageBucket: 'healthhub-1f4bd.appspot.com',
    iosBundleId: 'com.example.healthhub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDCEPAaP8eW_QLYH1DuIO_ayoUtSRbJCs4',
    appId: '1:841873054698:ios:78e6f0f3a390bc63e3b093',
    messagingSenderId: '841873054698',
    projectId: 'healthhub-1f4bd',
    storageBucket: 'healthhub-1f4bd.appspot.com',
    iosBundleId: 'com.example.healthhub.RunnerTests',
  );
}