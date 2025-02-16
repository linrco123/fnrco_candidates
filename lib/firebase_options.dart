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
    apiKey: 'AIzaSyAhBMUsKlbGH-9KiT5bX-n6DtGbKOtU0CA',
    appId: '1:997388103100:web:47006dc08eb8863a0d4fb9',
    messagingSenderId: '997388103100',
    projectId: 'fnrco-candidates-f3ab1',
    authDomain: 'fnrco-candidates-f3ab1.firebaseapp.com',
    storageBucket: 'fnrco-candidates-f3ab1.firebasestorage.app',
    measurementId: 'G-PCKF80979E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpT0L0DUQbER8bw-uGIOSO8ya8c2J0wqk',
    appId: '1:997388103100:android:92171b1ccb016dcc0d4fb9',
    messagingSenderId: '997388103100',
    projectId: 'fnrco-candidates-f3ab1',
    storageBucket: 'fnrco-candidates-f3ab1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnx9139MRkvwOtn97JCzIbQRbGC4pRNx8',
    appId: '1:997388103100:ios:f6a40a4db95c9c990d4fb9',
    messagingSenderId: '997388103100',
    projectId: 'fnrco-candidates-f3ab1',
    storageBucket: 'fnrco-candidates-f3ab1.firebasestorage.app',
    iosBundleId: 'com.fnrco.candidatesapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnx9139MRkvwOtn97JCzIbQRbGC4pRNx8',
    appId: '1:997388103100:ios:15128649278b8bb70d4fb9',
    messagingSenderId: '997388103100',
    projectId: 'fnrco-candidates-f3ab1',
    storageBucket: 'fnrco-candidates-f3ab1.firebasestorage.app',
    iosBundleId: 'com.example.fnrcoCandidates',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAhBMUsKlbGH-9KiT5bX-n6DtGbKOtU0CA',
    appId: '1:997388103100:web:3fc7429e5ce0e2430d4fb9',
    messagingSenderId: '997388103100',
    projectId: 'fnrco-candidates-f3ab1',
    authDomain: 'fnrco-candidates-f3ab1.firebaseapp.com',
    storageBucket: 'fnrco-candidates-f3ab1.firebasestorage.app',
    measurementId: 'G-H8Z52PS15L',
  );
}
