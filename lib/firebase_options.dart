import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
      apiKey: "AIzaSyBzl9EfJVvimjWU4FM8jwVQyus-1ySj0Jo",
      authDomain: "fire-setup-b0133.firebaseapp.com",
      projectId: "fire-setup-b0133",
      storageBucket: "fire-setup-b0133.appspot.com",
      messagingSenderId: "1070034842443",
      appId: "1:1070034842443:web:5e520f5299c3924c8feece");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKk4fDZW33tYBMLoqVWkLUj44kPBRrBWA',
    appId: '1:1070034842443:android:45023961f2885e538feece',
    messagingSenderId: '1070034842443',
    projectId: 'fire-setup-b0133',
    storageBucket: 'fire-setup-b0133.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlgsPCJaBd1LS1scsRyHwY-8PQf7vqjrI', 
    appId: '1:1070034842443:ios:27c8917639fab2478feece', 
    messagingSenderId: '1070034842443', 
    projectId: 'fire-setup-b0133',
    storageBucket: 'fire-setup-b0133.appspot.com', 
    iosBundleId: 'com.example.baiGk', 
  );
}
 