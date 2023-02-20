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
    apiKey: 'AIzaSyBEO1DSzYkbujpnPl-fsTEtcit8CIm4AXo',
    appId: '1:322960719879:web:d182e8c1d3c0783e106aa2',
    messagingSenderId: '322960719879',
    projectId: 'radish-app-d22bd',
    authDomain: 'radish-app-d22bd.firebaseapp.com',
    storageBucket: 'radish-app-d22bd.appspot.com',
    measurementId: 'G-KGMG777WWG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5fiSsONctmjgrUS_rPz5JwOqWOhApefs',
    appId: '1:322960719879:android:597401b9f456f9be106aa2',
    messagingSenderId: '322960719879',
    projectId: 'radish-app-d22bd',
    storageBucket: 'radish-app-d22bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoqVJRi_rCPtUMQ1OcUoG8iy0kBkX8LSk',
    appId: '1:322960719879:ios:13e77a7beae8b196106aa2',
    messagingSenderId: '322960719879',
    projectId: 'radish-app-d22bd',
    storageBucket: 'radish-app-d22bd.appspot.com',
    iosClientId: '322960719879-p78rg52pdrp35tt83vhg6u6gpsk2jtqr.apps.googleusercontent.com',
    iosBundleId: 'com.ldk.radishApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoqVJRi_rCPtUMQ1OcUoG8iy0kBkX8LSk',
    appId: '1:322960719879:ios:13e77a7beae8b196106aa2',
    messagingSenderId: '322960719879',
    projectId: 'radish-app-d22bd',
    storageBucket: 'radish-app-d22bd.appspot.com',
    iosClientId: '322960719879-p78rg52pdrp35tt83vhg6u6gpsk2jtqr.apps.googleusercontent.com',
    iosBundleId: 'com.ldk.radishApp',
  );
}
