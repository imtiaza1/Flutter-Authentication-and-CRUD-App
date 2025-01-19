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
    apiKey: 'AIzaSyCcyW_QG8UztvVGbG4C5PyvwUcSgUDGoGE',
    appId: '1:189286779865:web:df2fab6ba4b692d06027c8',
    messagingSenderId: '189286779865',
    projectId: 'todolist-b22a5',
    authDomain: 'todolist-b22a5.firebaseapp.com',
    storageBucket: 'todolist-b22a5.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoWwqRZV9n_LWsdwcHBNbiTQ7H4M2cBL0',
    appId: '1:189286779865:android:a482c99d10bf591a6027c8',
    messagingSenderId: '189286779865',
    projectId: 'todolist-b22a5',
    storageBucket: 'todolist-b22a5.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEa3mKwoDaeKPc2i5NGRuiKPUHEjDA-UI',
    appId: '1:189286779865:ios:f1dd3fdef036db3e6027c8',
    messagingSenderId: '189286779865',
    projectId: 'todolist-b22a5',
    storageBucket: 'todolist-b22a5.firebasestorage.app',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEa3mKwoDaeKPc2i5NGRuiKPUHEjDA-UI',
    appId: '1:189286779865:ios:f1dd3fdef036db3e6027c8',
    messagingSenderId: '189286779865',
    projectId: 'todolist-b22a5',
    storageBucket: 'todolist-b22a5.firebasestorage.app',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCcyW_QG8UztvVGbG4C5PyvwUcSgUDGoGE',
    appId: '1:189286779865:web:c01411fc3edb83e16027c8',
    messagingSenderId: '189286779865',
    projectId: 'todolist-b22a5',
    authDomain: 'todolist-b22a5.firebaseapp.com',
    storageBucket: 'todolist-b22a5.firebasestorage.app',
  );

}