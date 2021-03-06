// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIgKfQfSCdMW9qpd_AlUZbjw3WI5kF_K4',
    appId: '1:533045151706:android:cf5bbd509c227fb535e2e3',
    messagingSenderId: '533045151706',
    projectId: 'crowdate-db',
    storageBucket: 'crowdate-db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQVSPfWf32JJNrudyWXgfH70Ik3zPyVkM',
    appId: '1:533045151706:ios:fa2ce9c2cdf84d8d35e2e3',
    messagingSenderId: '533045151706',
    projectId: 'crowdate-db',
    storageBucket: 'crowdate-db.appspot.com',
    iosClientId: '533045151706-09safj4k4ip26hmqkfmfsdfve10pk3oh.apps.googleusercontent.com',
    iosBundleId: 'com.crowdate.app',
  );
}
