import 'package:crowdate/pages/splash.dart';
import 'package:crowdate/util/notificationutil.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();
  await NotificationUtil().init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  openDatabase(
    join(await getDatabasesPath(), "events.db"),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE events(id TEXT PRIMARY KEY, name TEXT, date TEXT, imageURL TEXT, genre TEXT, subGenre TEXT, currency TEXT, minPrice DOUBLE, maxPrice DOUBLE, address TEXT, info TEXT)',
      );
    },
    version: 1,
  );

  await dotenv.load();
  runApp(ChangeNotifierProvider(
      create: (_) => EventListViewModel(), child: const CrowDate()));
}

class CrowDate extends StatelessWidget {
  const CrowDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrowDate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
