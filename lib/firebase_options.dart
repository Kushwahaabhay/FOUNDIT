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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_API_KEY_HERE',
    appId: 'YOUR_APP_ID_HERE',
    messagingSenderId: 'YOUR_SENDER_ID_HERE',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.firebasestorage.app',
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
