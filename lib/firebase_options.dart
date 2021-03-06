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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDedg2Ou0GkTJbmLYJpLbEYAsfrbbmv8Ng',
    appId: '1:20487191304:android:4e9beb726e7fd4df144abd',
    messagingSenderId: '20487191304',
    projectId: 'practise-99196',
    storageBucket: 'practise-99196.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXJbXoK2VhbCklYNFqKEzFtGe6-_1T9Qw',
    appId: '1:20487191304:ios:8a5efbd87a7a68bc144abd',
    messagingSenderId: '20487191304',
    projectId: 'practise-99196',
    storageBucket: 'practise-99196.appspot.com',
    iosClientId: '20487191304-km6vnqjdtkjn51drcdgou349pbq6b8cq.apps.googleusercontent.com',
    iosBundleId: 'com.example.practise',
  );
}
