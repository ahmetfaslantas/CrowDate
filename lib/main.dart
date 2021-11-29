import 'package:crowdate/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(const CrowDate());
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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
