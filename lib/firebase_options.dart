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
    apiKey: 'AIzaSyAJMEpFEJS4IVqZ_SjD4zGGF6igacUwAhU',
    appId: '1:282532356204:web:b9ff88b4b52a734499b849',
    messagingSenderId: '282532356204',
    projectId: 'deciml-test',
    authDomain: 'deciml-test.firebaseapp.com',
    storageBucket: 'deciml-test.appspot.com',
    measurementId: 'G-22LVPZLG3G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAiGqeBtXFwrMsrJvqeODVT3AOxD71aGx4',
    appId: '1:282532356204:android:ebb3e7198583e24b99b849',
    messagingSenderId: '282532356204',
    projectId: 'deciml-test',
    storageBucket: 'deciml-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOGxplEjgIt6A8R5v60gFXVn9o4jSdlrY',
    appId: '1:282532356204:ios:3a960aa89027d38d99b849',
    messagingSenderId: '282532356204',
    projectId: 'deciml-test',
    storageBucket: 'deciml-test.appspot.com',
    iosClientId:
        '282532356204-2vs3n04a9mblcl1vpgjfbre2an407q62.apps.googleusercontent.com',
    iosBundleId: 'com.example.decimlAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOGxplEjgIt6A8R5v60gFXVn9o4jSdlrY',
    appId: '1:282532356204:ios:d40932c5d167840e99b849',
    messagingSenderId: '282532356204',
    projectId: 'deciml-test',
    storageBucket: 'deciml-test.appspot.com',
    iosClientId:
        '282532356204-32tf38ndqkfs5qnudm5jj4vgvp0phffm.apps.googleusercontent.com',
    iosBundleId: 'com.example.decimlAssignment.RunnerTests',
  );
}
