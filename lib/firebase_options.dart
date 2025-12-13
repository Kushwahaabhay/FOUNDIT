// File generated manually for FOUNDIT app
// TODO: Replace the placeholder values with your actual Firebase configuration
// Get these values from: Firebase Console > Project Settings > Your apps > SDK setup

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0s-YHy_y-iouEJspidAjtzGr1KoCzG98',
    appId: '1:1087756801292:android:80a589d71259314ed6e529',
    messagingSenderId: '1087756801292',
    projectId: 'foundit-gcet',
    storageBucket: 'foundit-gcet.firebasestorage.app',
  );

  // Web configuration - uses same project as Android

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDeZDQwKydRCtnmiLdrb9FKNjYpdDyGnto',
    appId: '1:1087756801292:web:b6bd5c26a04743aed6e529',
    messagingSenderId: '1087756801292',
    projectId: 'foundit-gcet',
    authDomain: 'foundit-gcet.firebaseapp.com',
    storageBucket: 'foundit-gcet.firebasestorage.app',
  );

  // TODO: Update these with your actual Firebase web config from Firebase Console

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWxeYyZBKbb9m9N7a3rbMZge70cQvenOo',
    appId: '1:1087756801292:ios:2f078d4284e6a062d6e529',
    messagingSenderId: '1087756801292',
    projectId: 'foundit-gcet',
    storageBucket: 'foundit-gcet.firebasestorage.app',
    androidClientId: '1087756801292-65g37bfd8cnrt082uc9l56idd66iargj.apps.googleusercontent.com',
    iosClientId: '1087756801292-le0rd4ktooeaq7o9hvo1h2kcd8vn8505.apps.googleusercontent.com',
    iosBundleId: 'com.gcet.foundit.founditApp',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWxeYyZBKbb9m9N7a3rbMZge70cQvenOo',
    appId: '1:1087756801292:ios:2f078d4284e6a062d6e529',
    messagingSenderId: '1087756801292',
    projectId: 'foundit-gcet',
    storageBucket: 'foundit-gcet.firebasestorage.app',
    androidClientId: '1087756801292-65g37bfd8cnrt082uc9l56idd66iargj.apps.googleusercontent.com',
    iosClientId: '1087756801292-le0rd4ktooeaq7o9hvo1h2kcd8vn8505.apps.googleusercontent.com',
    iosBundleId: 'com.gcet.foundit.founditApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDeZDQwKydRCtnmiLdrb9FKNjYpdDyGnto',
    appId: '1:1087756801292:web:f24f1bd03ff663abd6e529',
    messagingSenderId: '1087756801292',
    projectId: 'foundit-gcet',
    authDomain: 'foundit-gcet.firebaseapp.com',
    storageBucket: 'foundit-gcet.firebasestorage.app',
  );

}

/* 
INSTRUCTIONS TO FILL IN VALUES:

1. Go to Firebase Console: https://console.firebase.google.com/
2. Select your project: FOUNDIT-GCET
3. Click the gear icon ⚙️ next to "Project Overview"
4. Click "Project settings"
5. Scroll down to "Your apps" section
6. Click on your Android app
7. Look for "SDK setup and configuration"
8. Copy the values and replace above:

   apiKey: 'AIza...' (starts with AIza)
   appId: '1:123456789:android:abc123...' (starts with 1:)
   messagingSenderId: '123456789' (just numbers)
   projectId: 'foundit-gcet' (your project ID)
   storageBucket: 'foundit-gcet.appspot.com'

9. Save this file
10. Run: flutter run

Example of what it should look like:
  apiKey: 'AIzaSyDxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  appId: '1:123456789012:android:abcdef1234567890',
  messagingSenderId: '123456789012',
  projectId: 'foundit-gcet',
  storageBucket: 'foundit-gcet.appspot.com',
*/